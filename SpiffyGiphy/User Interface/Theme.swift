//
//  File.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/15/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

struct Theme {
    static func set() {
        let appearance = UINavigationBar.appearance()
        
        appearance.backgroundColor = .clear
        appearance.isTranslucent = false
        appearance.largeTitleTextAttributes = [NSAttributedStringKey.font: UIFont.title(size: 18)]
        appearance.tintColor = .white
        appearance.barTintColor = .black
        appearance.shadowImage = UIImage()
    }
}
