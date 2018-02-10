//
//  TrendingNavigationView.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/16/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class TrendingNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(topContainer)
        addSubview(bottomContainer)
        
        topContainer.addSubview(spiffyLogoLabel)
        topContainer.addSubview(giffyLogoLabel)
        topContainer.addSubview(titleLabel)
        
        //bottomContainer.addSubview(searchBar)
        
        backgroundColor = .black
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func updateConstraints() {
        let views: [String: Any] = [
            "topContainer": topContainer,
            "bottomContainer": bottomContainer,
            "spiffyLogoLabel": spiffyLogoLabel,
            "giffyLogoLabel": giffyLogoLabel,
            "titleLabel": titleLabel,
//            "searchBar": searchBar
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[topContainer]-20-[bottomContainer]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[topContainer]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[bottomContainer]|", options: [], metrics: nil, views: views))
        
        topContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[spiffyLogoLabel][giffyLogoLabel]", options: [.alignAllCenterY], metrics: nil, views: views))
        topContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[titleLabel]-|", options: [.alignAllCenterY], metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[spiffyLogoLabel]-|", options: [], metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[giffyLogoLabel]-|", options: [], metrics: nil, views: views))
//        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[titleLabel]-|", options: [], metrics: nil, views: views))
        
        
//        bottomContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[searchBar]-|", options: [.alignAllTrailing], metrics: nil, views: views))
//
//        bottomContainer.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[searchBar]-|", options: [.alignAllTrailing], metrics: nil, views: views))
        
        super.updateConstraints()
    }

    lazy private(set) var topContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy private(set) var bottomContainer: UIView = {
        let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy private(set) var spiffyLogoLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .logo(size: 24)
        l.textColor = .sg_orange
        l.text = "Spiffy"
        return l
    }()
    
    lazy private(set) var giffyLogoLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .logo(size: 24)
        l.textColor = .sg_yellow
        l.text = "Giffy"
        return l
    }()
    
    lazy private(set) var titleLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.font = .title(size: 24)
        l.textColor = .white
        l.text = "Trending Now"
        return l
    }()
    
    lazy private(set) var searchBar: UISearchBar = {
        let s = UISearchBar()
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
}
