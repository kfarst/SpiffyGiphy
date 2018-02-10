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
    fileprivate var keyboardLayoutConstraint: KeyboardLayoutConstraint?
    var bottomConstraint: NSLayoutConstraint?

    init(frame: CGRect, collectionViewLayout: UICollectionViewFlowLayout, dataSource: TrendingCollectionViewDataSource) {
        layout = collectionViewLayout
        
        self.dataSource = dataSource
        
        super.init(frame: frame)
        
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource

        addSubview(searchBar)
        addSubview(collectionView)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        let views: [String: UIView] = [
            "searchBar": searchBar,
            "collectionView": collectionView
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-11-[searchBar]-11-|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-10-[collectionView]-[searchBar(==40)]", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[collectionView]|", options: [], metrics: nil, views: views))
        
//        let bottomConstraint = NSLayoutConstraint(item: searchBar, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: -271)
        bottomConstraint = searchBar.bottomAnchor.constraint(equalTo: bottomAnchor)
        bottomConstraint?.constant = -271
        //searchBar.addConstraint(bottomConstraint)
        bottomConstraint?.isActive = true

        keyboardLayoutConstraint = KeyboardLayoutConstraint(constraint: bottomConstraint!)

        if let keyboardLayoutConstraint = keyboardLayoutConstraint {
            searchBar.addConstraint(keyboardLayoutConstraint)
            keyboardLayoutConstraint.isActive = true
        }

        super.updateConstraints()
    }
    
    lazy private(set) var searchBar: UITextView = {
        let s = UITextView()
        s.backgroundColor = .white
        s.translatesAutoresizingMaskIntoConstraints = false
        s.font = UIFont.systemFont(ofSize: 20)
        s.isEditable = true
        s.isUserInteractionEnabled = true
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
    
}
