//
//  UserImagePlaceholderView.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 3/6/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class UserImagePlaceholderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(letterLabel)
        
        setNeedsUpdateConstraints()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        letterLabel.layoutMargins = UIEdgeInsets(top: -5, left: -5, bottom: -5, right: -5)
        letterLabel.layer.cornerRadius = frame.width / 2
        letterLabel.clipsToBounds = true
    }
    
    override func updateConstraints() {
        let views: [String: UIView] = [
            "letterLabel": letterLabel
        ]
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[letterLabel]|", options: [], metrics: nil, views: views))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[letterLabel]|", options: [], metrics: nil, views: views))
        
        super.updateConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setPlaceholderLetter(text: String) {
        let letter = String(text[text.startIndex])
        letterLabel.text = letter.capitalized
    }

    lazy private(set) var letterLabel: UILabel = {
        let l = UILabel()
        l.translatesAutoresizingMaskIntoConstraints = false
        l.textColor = .white
        l.backgroundColor = .blue
        l.font = UIFont.title(size: 24)
        l.textAlignment = .center
        return l
    }()
}
