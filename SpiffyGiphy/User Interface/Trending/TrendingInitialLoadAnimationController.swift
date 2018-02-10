//
//  TrendingInitialLoadAnimationController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/11/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class TrendingInitialLoadAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 2.0
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // 1
        guard let fromVC = transitionContext.viewController(forKey: .from),
            let toVC = transitionContext.viewController(forKey: .to),
            let snapshot = toVC.view.snapshotView(afterScreenUpdates: true)
            else {
                return
        }
        
        // 2
        let containerView = transitionContext.containerView
        let finalFrame = transitionContext.finalFrame(for: toVC)
        
        toVC.view.isHidden = true
        containerView.addSubview(toVC.view)
        toVC.view.frame = containerView.frame
        
        if let navController = toVC as? SpiffyGiphyNavigationController, let firstController = navController.viewControllers.first as? TrendingCollectionViewController {
            let navigationBar = navController.navigationBar
            
            navigationBar.isHidden = true
            containerView.addSubview(navigationBar)
            //navigationBar.frame.origin.y = navigationBar.frame.origin.y - navigationBar.frame.height
            let slideInTop: CGAffineTransform  = CGAffineTransform(translationX: 0, y: navigationBar.frame.height)
            navigationBar.frame = toVC.view.frame.intersection(navigationBar.frame)
            navigationBar.transform = slideInTop.inverted()
            
            navigationBar.isHidden = false
            
            UIView.animate(withDuration: 0.5, animations: {
                navigationBar.transform = .identity
            }) { (completed) in
                
                let searchBar = firstController.trendingView.searchBar
                searchBar.isHidden = true
                containerView.addSubview(searchBar)
                searchBar.frame = toVC.view.frame.intersection(searchBar.frame)
                searchBar.frame.origin.y = toVC.view.frame.maxY - searchBar.frame.height
                
                let slideInLeft: CGAffineTransform  = CGAffineTransform(translationX: searchBar.frame.width, y: 0)
                searchBar.transform = slideInLeft.inverted()
                searchBar.isHidden = false
                
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 10, options: UIViewAnimationOptions.curveEaseIn, animations: {
                    searchBar.transform = .identity
                }, completion: { (completed) in
                    
                    let collectionView = firstController.trendingView.collectionView
                    collectionView.alpha = 0
                    containerView.addSubview(collectionView)
                    let slideInBottom: CGAffineTransform  = CGAffineTransform(translationX: 0, y: 20)
                    collectionView.frame = CGRect(x: 0, y: navigationBar.frame.maxY, width: toVC.view.frame.width, height: searchBar.frame.minY - navigationBar.frame.maxY - 5)
                    collectionView.transform = slideInBottom

                    UIView.animate(withDuration: 0.5, animations: {
                        collectionView.transform = .identity
                        collectionView.alpha = 1
                    }, completion: { (completed) in
                        toVC.view.isHidden = false
                        transitionContext.completeTransition(completed)
                    })
                })
            }
        }
    }
}
