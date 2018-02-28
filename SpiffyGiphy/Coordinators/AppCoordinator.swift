//
//  AppCoordinator.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var rootViewController: UIViewController
    var childCoordinators = [Coordinator]()
    
    init(with rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func start() {
        Theme.set()
        
        if let rootViewController = self.rootViewController as? FirstLoadViewController {
            rootViewController.delegate = self
        }
    }
}

extension AppCoordinator: FirstLoadViewControllerDelegate {
    func showTrendingView() {
        let layout = ColumnFlowLayout(
            cellsPerRow: 2,
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        )
        
        let transitioningDelegate = TrendingInitialLoadTransitioningDelegate()
        
        let trendingVC: TrendingCollectionViewController = {
            let vc = TrendingCollectionViewController(
                collectionViewLayout: layout,
                client: GiphyApiClient.shared
            )
            vc.transitioningDelegate = transitioningDelegate
            
            vc.coordinator = addChildCoordinator(childCoordinator: TrendingSearchFlowCoordinator(with: vc)) as? TrendingSearchFlowCoordinator
            
            return vc
        }()
        
        rootViewController.present({
            let navigationVC = SpiffyGiphyNavigationController(navigationBarClass: TrendingNavigationBar.self, toolbarClass: nil)
            
            let delegate = NavDelegate()

            navigationVC.delegate = delegate
            navigationVC.transitioningDelegate = transitioningDelegate
            
            navigationVC.coordinator = self
            navigationVC.addChildViewController(trendingVC)
            
            return navigationVC
        }(), animated: true, completion: nil)
    }
}
