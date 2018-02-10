//
//  GifImageType.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/27/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

struct GifImageType: Codable {
    let description: String?
    let image: GifImage?
    
    enum CodingKeys: String, CodingKey {
        case description
        case image
    }
}
