//
//  TrendingView.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/5/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class TrendingView: UIView {
    var dataSource: TrendingCollectionViewDataSource
    fileprivate let layout: UICollectionViewFlowLayout

    init(frame: CGRect, collectionViewLayout: UICollectionViewFlowLayout, dataSource: TrendingCollectionViewDataSource) {
        layout = collectionViewLayout
        
        self.dataSource = dataSource
        
        super.init(frame: frame)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource

        addSubview(searchBar)
        addSubview(searchButton)
        insertSubview(collectionView, belowSubview: searchBar)
        insertSubview(searchFocusView, belowSubview: searchBar)

        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        let views: [String: UIView] = [
            "searchBar": searchBar,
            "searchButton": searchButton,
            "collectionView": collectionView,
            "searchFocusView": searchFocusView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchBar][searchButton(==40)]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]-[searchBar(==40)]", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[collectionView]-[searchButton(==searchBar)]", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[searchFocusView]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[searchFocusView]|", options: [], metrics: nil, views: views))
        
        let keyboardLayoutConstraint = KeyboardLayoutConstraint(item: searchBar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -10)

        addConstraint(keyboardLayoutConstraint)
        keyboardLayoutConstraint.isActive = true

        super.updateConstraints()
    }
    
    lazy private(set) var searchBar: UITextField = {
        let s = UITextField()
        s.backgroundColor = .white
        s.translatesAutoresizingMaskIntoConstraints = false
        s.font = UIFont.systemFont(ofSize: 20)
        s.isUserInteractionEnabled = true
        s.placeholder = "Whatcha lookin' for?"
        s.returnKeyType = .search
        s.enablesReturnKeyAutomatically = true
        s.clearButtonMode = .whileEditing
        return s
    }()
    
    lazy private(set) var collectionViewTopDivider: UIView = {
        let v = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 100))
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .blue
        
        let gradient = CAGradientLayer()
        gradient.frame = v.bounds
        gradient.colors = [UIColor.black, UIColor.green]
        gradient.locations = [0, 1]
        //v.layer.addSublayer(gradient)
        
        return v
    }()
    
    lazy private(set) var collectionView: UICollectionView = {
        let c = UICollectionView(frame: .zero, collectionViewLayout: layout)
        c.translatesAutoresizingMaskIntoConstraints = false
        c.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
        return c
    }()
    
    lazy private(set) var searchFocusView: UIView = {
      let v = UIView()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.backgroundColor = .black
        v.isUserInteractionEnabled = true
        v.alpha = 0.5
        return v
    }()
    
    lazy private(set) var searchButton: UIButton = {
        let b = UIButton(type: .contactAdd)
        b.translatesAutoresizingMaskIntoConstraints = false
        b.backgroundColor = .black
        b.tintColor = .white
        return b
    }()
}
