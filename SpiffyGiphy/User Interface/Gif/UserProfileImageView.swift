//
//  UserProfileImageView.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 3/8/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class UserProfileImageView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(placeholderView)
        addSubview(imageView)
        
        placeholderView.isHidden = true
        imageView.isHidden = true
        
        setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.layer.cornerRadius = imageView.frame.size.width / 2
        placeholderView.layer.cornerRadius = placeholderView.frame.size.width / 2
    }
    
    override func updateConstraints() {
        let views: [String: UIView] = [
            "placeholderView": placeholderView,
            "imageView": imageView
        ]
        
//        placeholderView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        placeholderView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
//
//        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
//        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[placeholderView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[placeholderView]|", options: [], metrics: nil, views: views))
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[imageView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[imageView]|", options: [], metrics: nil, views: views))
        
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlaceholderText(_ text: String) {
        placeholderView.setPlaceholderLetter(text: text)
        placeholderView.isHidden = false
    }
    
    func setImage(_ image: UIImage) {
        imageView.image = image
        imageView.isHidden = false
    }

    lazy private(set) var placeholderView: UserImagePlaceholderView = {
        let u = UserImagePlaceholderView()
        u.translatesAutoresizingMaskIntoConstraints = false
        return u
    }()
    
    lazy private(set) var imageView: UIImageView = {
        let i = UIImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFit
        i.layer.masksToBounds = true
        return i
    }()
}
