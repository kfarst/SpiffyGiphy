//
//  UIFont.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/15/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

extension UIFont {
    static func title(size: CGFloat) -> UIFont {
        return UIFont(name: "AvenirNextCondensed-Heavy", size: size)!
    }
    
    static func logo(size: CGFloat) -> UIFont {
        return UIFont(name: "Chalkduster", size: size)!
    }
}
