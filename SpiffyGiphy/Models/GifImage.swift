//
//  GifImage.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/26/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation


struct GifImage: Codable {
    let url: String?
    let width: String?
    let height: String?
    let size: String?
    
    enum CodingKeys: String, CodingKey {
        case url
        case width
        case height
        case size
    }
}
