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
    
    private let factory: CoordinatorFactory
    private var tabBarController: UITabBarController
 
    init(tabBarController: UITabBarController, factory: CoordinatorFactory = CoordinatorFactoryImpl()) {
        self.tabBarController = tabBarController
        self.factory = factory
        
        super.init()
        
        tabBarController.delegate = self
    }

    func start() {
        let firstNavController = UINavigationController()
        firstNavController.tabBarItem.title = "First"
        let firstRouter = RouterImpl(rootController: firstNavController)
        var tab1Coordinator = factory.makeTab1Coordinator(router: firstRouter, factory: factory)
        tab1Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }

        let secondNavController = UINavigationController()
        secondNavController.tabBarItem.title = "Second"
        let secondRouter = RouterImpl(rootController: secondNavController)
        var tab2Coordinator = factory.makeTab2Coordinator(router: secondRouter, factory: factory)
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
