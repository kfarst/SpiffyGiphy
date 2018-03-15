//
//  LogoView.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 3/13/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class LogoView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(spiffyLogoLabel)
        addSubview(giffyLogoLabel)
        
        setNeedsUpdateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        let views: [String: Any] = [
            "spiffyLogoLabel": spiffyLogoLabel,
            "giffyLogoLabel": giffyLogoLabel,
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[spiffyLogoLabel][giffyLogoLabel]|", options: [.alignAllCenterY], metrics: nil, views: views))
        
        super.updateConstraints()
    }

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
    
}
