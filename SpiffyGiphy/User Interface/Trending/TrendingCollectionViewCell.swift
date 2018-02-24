//
//  TrendingCollectionViewCell.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/15/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit
import Gifu

class TrendingCollectionViewCell: UICollectionViewCell {
    var gifSource: GifImage? {
        didSet {
            backgroundView = nil
            
            DispatchQueue.global().async {
                if let url = self.gifSource?.url, let urlObj = URL(string: url), let data = try? Data(contentsOf: urlObj) {
                    DispatchQueue.main.async {
                        self.backgroundImageView.animate(withGIFData: data)
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.prepareForReuse()
    }
    
    lazy private(set) var backgroundImageView: GIFImageView = {
        let i = GIFImageView()
        i.backgroundColor = .blue
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
}
