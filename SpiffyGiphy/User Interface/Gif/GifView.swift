//
//  GifView.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/26/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit
import Gifu

class GifView: UIView {
    fileprivate let gif: GifImage
    
    init(frame: CGRect, gif: GifImage) {
        self.gif = gif
        
        super.init(frame: frame)
                
        addSubview(gifImageView)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        let views: [String: UIView] = [
            "gifImageView": gifImageView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gifImageView]|", options: [], metrics: nil, views: views))
        
        var gifHeight: CGFloat
        
        if gif.height != nil, let heightNumber = NumberFormatter().number(from: gif.height!) {
            let heightFloat = CGFloat(truncating: heightNumber)
            gifHeight = (heightFloat / frame.width) * heightFloat
        } else {
            gifHeight = frame.width
        }
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[gifImageView(==gifImageHeight)]", options: [], metrics: ["gifImageHeight": gifHeight], views: views))
        
        super.updateConstraints()
    }
    
    lazy private(set) var gifImageView: GIFImageView = {
        let i = GIFImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
}
