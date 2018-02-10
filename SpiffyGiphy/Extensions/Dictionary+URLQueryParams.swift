//
//  Dictionary.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/24/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import Foundation

extension Dictionary {
    func toQueryItems() -> [URLQueryItem] {
        var items: [URLQueryItem] = [URLQueryItem]()
        
        for pair in self.enumerated() {
            if let key = pair.element.key as? String, let value = pair.element.value as? String {
                items.append(URLQueryItem(name: key, value: value))
            }
        }
        
        return items
    }
}
