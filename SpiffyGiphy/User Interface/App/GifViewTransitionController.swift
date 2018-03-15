//
//  GifViewTransitionController.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/9/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

class GifViewTransitionController : NSObject, UIViewControllerAnimatedTransitioning {
    var duration : TimeInterval
    var isPresenting : Bool
    var originFrame : CGRect

    init(duration : TimeInterval, isPresenting : Bool, originFrame : CGRect) {
        self.duration = duration
        self.isPresenting = isPresenting
        self.originFrame = originFrame
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let container = transitionContext.containerView
        
        guard let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from) else { return }
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) else { return }
        
        self.isPresenting ? container.addSubview(toView) : container.insertSubview(toView, belowSubview: fromView)
        
        let detailView = isPresenting ? toView : fromView
        
        toView.frame = isPresenting ?  CGRect(x: fromView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height) : toView.frame
        toView.alpha = isPresenting ? 0 : 1
        toView.layoutIfNeeded()
        
        let fromVC = transitionContext.viewController(forKey: isPresenting ? UITransitionContextViewControllerKey.from : UITransitionContextViewControllerKey.to)
        
        let toVC = transitionContext.viewController(forKey: isPresenting ? UITransitionContextViewControllerKey.to : UITransitionContextViewControllerKey.from)

        if let navBar = fromVC?.navigationController?.navigationBar as? TrendingNavigationBar {
            UIView.animate(withDuration: 0.5, animations: {
                if let backButton = toVC?.navigationItem {
                    backButton.title = ""
                }
                
                navBar.titleLabel.alpha = self.isPresenting ? 0 : 1
                let xTranslation = self.isPresenting ? navBar.titleLabel.frame.origin.x + navBar.titleLabel.frame.width - navBar.logoView.frame.width - navBar.safeAreaInsets.right : 0

                navBar.logoView.transform = CGAffineTransform(translationX: xTranslation, y: 0)
            })
        }

        UIView.animate(withDuration: duration, animations: {
            detailView.frame = self.isPresenting ? fromView.frame : CGRect(x: toView.frame.width, y: 0, width: toView.frame.width, height: toView.frame.height)
            detailView.alpha = self.isPresenting ? 1 : 0
        }, completion: { (finished) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
}
