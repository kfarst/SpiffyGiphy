//
//  GifsList.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/24/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

struct MediaItem: Codable {
    let title: String?
    let type: String?
    let id: String?
    let slug: String?
    let url: String?
    let bitlyGifUrl: String?
    let bitlyUrl: String?
    let embedUrl: String?
    let username: String?
    let source: String?
    let rating: String?
    let contentUrl: String?
    let sourceTld: String?
    let sourcePostUrl: String?
    let isIndexable: Bool?
    let isSticker: Bool?
    let importDatetime: Date?
    let trendingDatetime: Date?
    let user: GiphyUser?
    let images: [String: GifImage]?

    enum CodingKeys: String, CodingKey {
        case title
        case type
        case id
        case slug
        case url
        case bitlyGifUrl
        case bitlyUrl
        case embedUrl
        case username
        case source
        case rating
        case contentUrl
        case sourceTld
        case sourcePostUrl
        case isIndexable
        case isSticker
        case importDatetime
        case trendingDatetime
        case user
        case images
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        title = try? container.decode(String.self, forKey: .title)
        type = try? container.decode(String.self, forKey: .type)
        id = try? container.decode(String.self, forKey: .id)
        slug = try? container.decode(String.self, forKey: .slug)
        url = try? container.decode(String.self, forKey: .url)
        bitlyGifUrl = try? container.decode(String.self, forKey: .bitlyGifUrl)
        bitlyUrl = try? container.decode(String.self, forKey: .bitlyUrl)
        embedUrl = try? container.decode(String.self, forKey: .embedUrl)
        username = try? container.decode(String.self, forKey: .username)
        source = try? container.decode(String.self, forKey: .source)
        rating = try? container.decode(String.self, forKey: .rating)
        contentUrl = try? container.decode(String.self, forKey: .contentUrl)
        sourceTld = try? container.decode(String.self, forKey: .sourceTld)
        sourcePostUrl = try? container.decode(String.self, forKey: .sourcePostUrl)
        isIndexable = try? container.decode(Bool.self, forKey: .isIndexable)
        isSticker = try? container.decode(Bool.self, forKey: .isSticker)
        importDatetime = try? container.decode(Date.self, forKey: .importDatetime)
        trendingDatetime = try? container.decode(Date.self, forKey: .trendingDatetime)
        user = try? container.decode(GiphyUser.self, forKey: .user)
        images = try? container.decode([String: GifImage].self, forKey: .images)
    }
}
