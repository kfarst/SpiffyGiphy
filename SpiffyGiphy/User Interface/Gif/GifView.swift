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
        
        addSubview(scrollView)
        
        scrollView.addSubview(gifImageView)
        scrollView.addSubview(titleLabel)
        scrollView.addSubview(userInfoStackView)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        let views: [String: UIView] = [
            "scrollView": scrollView,
            "gifImageView": gifImageView,
            "titleLabel": titleLabel,
            "userInfoStackView": userInfoStackView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[scrollView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[scrollView]|", options: [], metrics: nil, views: views))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[gifImageView(==fullWidth)]|", options: [], metrics: ["fullWidth": frame.width], views: views))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[titleLabel]-|", options: [], metrics: nil, views: views))
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[userInfoStackView]-|", options: [], metrics: nil, views: views))
        
        scrollView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[gifImageView(==300)]-[titleLabel]-[userInfoStackView]", options: [], metrics: nil, views: views))
        
        userProfileImageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
        userProfileImageView.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        super.updateConstraints()
    }
    
    lazy private(set) var scrollView: UIScrollView = {
        let s = UIScrollView()
        s.translatesAutoresizingMaskIntoConstraints = false
        s.showsHorizontalScrollIndicator = false
        return s
    }()
    
    lazy private(set) var gifImageView: GIFImageView = {
        let i = GIFImageView()
        i.translatesAutoresizingMaskIntoConstraints = false
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
    
    lazy private(set) var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.title(size: 24)
        l.numberOfLines = 0
        return l
    }()
    
    lazy private(set) var userProfileImageView: UserProfileImageView = {
        let v = UserProfileImageView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()

    lazy private(set) var usernameLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.font = UIFont.title(size: 18)
        return l
    }()
    
    lazy private(set) var userInfoStackView: UIStackView = {
        let s = UIStackView(arrangedSubviews: [
            userProfileImageView,
            usernameLabel
        ])
        
        s.translatesAutoresizingMaskIntoConstraints = false
        s.axis = .horizontal
        s.alignment = .center
        s.distribution = .fillProportionally
        s.spacing = 5
        return s
    }()
}
