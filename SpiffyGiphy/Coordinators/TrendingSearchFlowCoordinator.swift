//
//  TrendingSearchFlowCoordinator.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/15/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class TrendingSearchFlowCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var rootViewController: UIViewController

    init(with rootViewController: UIViewController) {
        self.rootViewController = rootViewController
    }
    
    func showDetailViewFor(mediaItem: MediaItem) {
        guard let navVC = rootViewController.navigationController else {
            return
        }
        
        let detailVC = UIViewController()
        
        navVC.pushViewController(detailVC, animated: true)
    }
}
