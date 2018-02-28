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
            
            if let url = self.gifSource?.url {
                DispatchQueue.global().async {
                    if let urlObj = URL(string: url), let data = try? Data(contentsOf: urlObj) {
                        DispatchQueue.main.async {
                            if let url = url as? NSString, let data = data as? NSData {
                                GifCache.shared.setObject(data, forKey: url)
                            }

                            self.backgroundImageView.animate(withGIFData: data)
                            self.backgroundView = self.backgroundImageView
                            self.isUserInteractionEnabled = true
                        }
                    }
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        
        isUserInteractionEnabled = false
        
        contentView.addSubview(backgroundImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.prepareForReuse()
        isUserInteractionEnabled = false
    }
    
    lazy private(set) var backgroundImageView: GIFImageView = {
        let i = GIFImageView()
        i.contentMode = .scaleAspectFill
        i.clipsToBounds = true
        return i
    }()
}
