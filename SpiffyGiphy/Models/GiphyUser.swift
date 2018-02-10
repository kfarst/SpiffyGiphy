//
//  GiphyUser.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/25/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

struct GiphyUser: Codable {
    let avatarUrl: String?
    let bannerUrl: String?
    let profileUrl: String?
    let username: String?
    let displayName: String?
    let twitter: String?
    let isVerified: Bool?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl
        case bannerUrl
        case profileUrl
        case username
        case displayName
        case twitter
        case isVerified
    }
}
