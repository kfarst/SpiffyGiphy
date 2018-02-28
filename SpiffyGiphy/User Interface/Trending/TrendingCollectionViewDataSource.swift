//
//  TrendingCollectionViewDataSource.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/15/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class TrendingCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    var gifs: [MediaItem] = [MediaItem]()
    fileprivate let coordinator: TrendingSearchFlowCoordinator
    
    init(with coordinator: TrendingSearchFlowCoordinator) {
        self.coordinator = coordinator
        super.init()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gifs.count > 0 ? gifs.count : 30
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? TrendingCollectionViewCell
        
        if cell == nil {
            cell = TrendingCollectionViewCell()
        }
        
        if indexPath.row < gifs.count {
            let gif = gifs[indexPath.row]
            
            if let image = gif.images?["original"] {
                cell?.gifSource = image
            }
        }
        
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let mediaItem = gifs[indexPath.row]
        
        if let gif = mediaItem.images?["original"] {
            coordinator.showDetailViewFor(gif)
        }
    }
}

extension TrendingCollectionViewDataSource : DynamicLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath) -> CGFloat {
        if let image = gifs[indexPath.row].images?["original"], let height = image.height, let heightFloat = NumberFormatter().number(from: height)  {
            return CGFloat(truncating: heightFloat)
        } else {
            return 100
        }
    }
    
}
