//
//  TrendingCollectionViewCell.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/15/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class TrendingCollectionViewCell: UICollectionViewCell {
    var gifSource: GifImage? {
        didSet {
            backgroundView = nil
            
            DispatchQueue.global().async {
                if let url = self.gifSource?.url, let urlObj = URL(string: url), let data = try? Data(contentsOf: urlObj) {
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        self.backgroundImageView.image = image
                        self.backgroundView = self.backgroundImageView
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray

        contentView.addSubview(backgroundImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private(set) var backgroundImageView: UIImageView = {
        let i = UIImageView()
        i.backgroundColor = .blue
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
}
