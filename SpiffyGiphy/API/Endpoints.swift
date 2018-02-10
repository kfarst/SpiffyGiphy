//
//  Endpoints.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

enum Endpoints {
    case search
    case trending

    var url: URL {
        let baseUrl: String
        let path: String
        
        switch self {
        case .search:
            path = "/search"
            baseUrl = GiphyApiClient.baseURL
        case .trending:
            path = "/trending"
            baseUrl = GiphyApiClient.baseURL
        }
        
        return URL(string: baseUrl + path)!
    }
}
