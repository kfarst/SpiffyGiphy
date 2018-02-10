//
//  GifsList.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/31/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

struct GifsList: Codable {
    let data: [MediaItem]
    
    enum CodingKeys: String, CodingKey {
        case data
    }
}
