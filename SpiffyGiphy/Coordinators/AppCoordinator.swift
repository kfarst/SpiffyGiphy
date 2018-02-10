//
//  AppCoordinator.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/10/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get }
    var rootViewController: UIViewController { get }
}
class AppCoordinator: Coordinator {
    var rootViewController:UIViewController
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
        
        let vc = TrendingCollectionViewController(
            collectionViewLayout: layout,
            client: GiphyApiClient(configuration: URLSessionConfiguration.default)
        )
        
        let delegate = TrendingInitialLoadTransitioningDelegate()
        vc.transitioningDelegate = delegate
        
        rootViewController.present({
            let navigationVC = SpiffyGiphyNavigationController(navigationBarClass: TrendingNavigationBar.self, toolbarClass: nil)
            let navDelegate = NavDelegate()
            navigationVC.delegate = navDelegate
            navigationVC.transitioningDelegate = delegate
            
            navigationVC.coordinator = self
            navigationVC.addChildViewController(vc)
            
            return navigationVC
        }(), animated: true, completion: nil)
    }
}
