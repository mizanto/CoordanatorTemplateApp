//
//  TabBarCoordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

/// Protocol helps pass data outside current coordinator and handle it in parent coordinator.
protocol TabBarCoordinatorOutput: AnyObject {
    var finishFlow: VoidClosure? { get set }
}

final class TabBarCoordinator: NSObject, Coordinator, TabBarCoordinatorOutput {
    
    var childCoordinators: [Coordinator] = []
    var finishFlow: VoidClosure?
    
    private var tabBarController: UITabBarController
 
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        
        super.init()
        
        tabBarController.delegate = self
    }

    func start() {
        let firstNavController = UINavigationController()
        firstNavController.tabBarItem.title = "First"
        var tab1Coordinator = CoordinatorFactory.makeTab1Coordinator(navigationController: firstNavController)
        tab1Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }

        let secondNavController = UINavigationController()
        secondNavController.tabBarItem.title = "Second"
        var tab2Coordinator = CoordinatorFactory.makeTab2Coordinator(navigationController: secondNavController)
        tab2Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        
        tabBarController.viewControllers = [
            firstNavController,
            secondNavController
        ]

        addDependency(tab1Coordinator)
        addDependency(tab2Coordinator)
        
        tab1Coordinator.start()
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarCoordinator: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let selectedCoordinator = childCoordinators[tabBarController.selectedIndex]
        selectedCoordinator.start()
    }
}
