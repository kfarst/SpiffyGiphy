//
//  Coordinator.swift
//  SpiffyGiphy
//
//  Created by Kevin Farst on 2/12/18.
//  Copyright © 2018 Kevin Farst. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var childCoordinators: [Coordinator] { get set }
    var rootViewController: UIViewController { get }
}

extension Coordinator {
    /// Add a child coordinator to the parent
    func addChildCoordinator(childCoordinator: Coordinator) -> Coordinator {
        self.childCoordinators.append(childCoordinator)
        return childCoordinator
    }
    
    /// Remove a child coordinator from the parent
    func removeChildCoordinator(childCoordinator: Coordinator) {
        self.childCoordinators = self.childCoordinators.filter { $0 !== childCoordinator }
    }
    
}
