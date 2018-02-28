//
//  GifCache.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/28/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

class GifCache: NSCache<NSString, NSData> {
    static let shared: GifCache = {
        return GifCache()
    }()
}
