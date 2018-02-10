//
//  GiphyApiClient.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

class GiphyApiClient: ApiClient {
    func getTrending(query: [String: Any]? = [:], _ completion: @escaping (_ result: ApiClientResult<GifsList>) -> Void) {
        let url = Endpoints.trending.url
        
        let q = defaultQueryItems.merging(query!) { (firstValue, secondValue) -> Any in
            return secondValue
        }
        
        let request = buildRequest("GET", url: url, params: q.toQueryItems())
        //return fetchFakeData(completion)
        return fetchResource(request: request, completion: completion)
    }

    lazy private(set) var defaultQueryItems: [String: Any] = {
        return ["api_key": GiphyApiClient.APIKey]
    }()
}

extension GiphyApiClient {
    static var baseURL: String {
        return Bundle.main.object(forInfoDictionaryKey: "GIPHY_API_URL") as! String
    }
    
    static var APIKey: String {
        return Bundle.main.object(forInfoDictionaryKey: "GIPHY_API_KEY") as! String
    }
    
    static var shared: GiphyApiClient = {
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Content-Type" : "application/json",
            "Accept" : "application/json"
        ]
        return GiphyApiClient(configuration: config)
    }()
}
