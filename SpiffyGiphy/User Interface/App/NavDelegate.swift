//
//  NavDelegate.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 1/11/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class NavDelegate: NSObject, UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        switch operation {
        case .push:
            return GifViewTransitionController(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: true, originFrame: fromVC.view.frame)
        default:
            return GifViewTransitionController(duration: TimeInterval(UINavigationControllerHideShowBarDuration), isPresenting: false, originFrame: fromVC.view.frame)
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        print("Did show")
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        print("Will show")
    }
}
