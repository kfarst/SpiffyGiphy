//
//  ApiClient.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

public enum ApiClientResult<T> {
    case Success(T)
    case Error(Error)
    case NotFound
    case ServerError(Int)
    case ClientError(Int)
    case UnexpectedResponse(Data)
}

fileprivate enum CustomError: Error {
    case Timeout
    case NoPayload
}

class ApiClient {
    typealias JsonTaskCompletionHandler = (Data?, HTTPURLResponse?, Error?) -> Void
    
    let configuration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    lazy var decoder: JSONDecoder = {
        let j = JSONDecoder()
        
        let d = DateFormatter()
        d.timeZone = TimeZone(identifier: "UTC")
        d.dateFormat = "yyyy-MM-dd hh:mm:ss"
        
        j.dateDecodingStrategy = .formatted(d)

        return j
    }()
    
    var currentTasks: Set<URLSessionDataTask> = []
    
    init(configuration: URLSessionConfiguration) {
        self.configuration = configuration
    }
    
    func jsonTaskWithRequest(request: URLRequest, completion: @escaping JsonTaskCompletionHandler) -> URLSessionDataTask {
        var task: URLSessionDataTask?
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            self.currentTasks.remove(task!)
            if let http = response as? HTTPURLResponse {
                if let e = error {
                    completion(nil, http, e)
                } else {
                    if let data = data {
                        completion(data, http, nil)
                    } else {
                        completion(nil, http, CustomError.NoPayload)
                    }
                }
            } else {
                completion(nil, nil, CustomError.Timeout)
            }
        })
        currentTasks.insert(task!)
        return task!
    }
    
    func fetch<T>(request: URLRequest, parseBlock: @escaping (Data) -> T?, completion: @escaping (ApiClientResult<T>) -> Void) {
        let task = jsonTaskWithRequest(request: request) { (json, response, error) in
            DispatchQueue.main.async() {
                if let e = error {
                    completion(.Error(e))
                } else {
                    switch response!.statusCode {
                    case 200:
                        if let resource = parseBlock(json!) {
                            completion(.Success(resource))
                        } else {
                            print("WARNING: Couldn't parse the following JSON as a \(T.self)")
                            print(json!)
                            completion(.UnexpectedResponse(json!))
                        }
                        
                    case 404: completion(.NotFound)
                    case 400...499: completion(.ClientError(response!.statusCode))
                    case 500...599: completion(.ServerError(response!.statusCode))
                    default:
                        print("Received HTTP \(response!.statusCode), which was not handled")
                    }
                }
            }
        }
        
        task.resume()
    }
    
    func fetchResource<T: Decodable>(request: URLRequest, rootKey: String? = nil, completion: @escaping (ApiClientResult<T>) -> Void) {
        fetch(request: request, parseBlock: { (data: Data) -> T? in
            
            do {
                let result = try self.decoder.decode(T.self, from: data)
                return result
            } catch let error {
                print("Decoding error: " + error.localizedDescription)
                return nil
            }
            
        }, completion: completion)
    }
    
    func fetchCollection<T: Decodable>(request: URLRequest, rootKey: String? = nil, completion: @escaping (ApiClientResult<[T]>) -> Void) {
        fetch(request: request, parseBlock: { (data) in
            
            do {
                let results = try self.decoder.decode(T.self, from: data)
                return results as! [T]
            } catch let error {
                print(error.localizedDescription)
                return []
            }
            
        }, completion: completion)
    }
    
    func buildRequest(_ verb: String, url: URL, params: [URLQueryItem]? = []) -> URLRequest {
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        urlComponents?.queryItems = params
        return URLRequest(url: urlComponents!.url!)
    }
}
