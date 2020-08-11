//
//  Coordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import Foundation

/// The main interface for all coordinators.
protocol Coordinator: AnyObject {
    /// Should be called when need to start particular flow.
    func start()
}

/// The base class for every coordinator.
class BaseCoordinator: NSObject, Coordinator {
    
    private var childCoordinators: [Coordinator] = []
    
    func start() {
        fatalError("Should be implemented in inherited class!")
    }
    
    func addDependency(_ coordinator: Coordinator) {
        guard !childCoordinators.contains(where: { $0 === coordinator }) else { return }
        childCoordinators.append(coordinator)
    }
    
    func removeDependency(_ coordinator: Coordinator?) {
        guard
            childCoordinators.isEmpty == false,
            let coordinator = coordinator else {
                return
        }
        
        // Clear child-coordinators recursively
        if let coordinator = coordinator as? BaseCoordinator,
           !coordinator.childCoordinators.isEmpty {
            coordinator.childCoordinators
                .filter { $0 !== coordinator }
                .forEach { coordinator.removeDependency($0) }
        }
        
        for (index, element) in childCoordinators.enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }
}
