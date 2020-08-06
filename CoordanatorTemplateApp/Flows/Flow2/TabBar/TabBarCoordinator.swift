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

final class TabBarCoordinator: BaseCoordinator, TabBarCoordinatorOutput {
    
    var finishFlow: VoidClosure?
    
    private var tabBarController: UITabBarController
    private var tab1Coordinator: (Coordinator & Tab1CoordinatorOutput)!
    private var tab2Coordinator: (Coordinator & Tab2CoordinatorOutput)!
    
    init(tabBarController: UITabBarController) {
        self.tabBarController = tabBarController
        
        super.init()
        
        tabBarController.delegate = self
    }

    override func start() {
        let firstNavController = UINavigationController()
        firstNavController.tabBarItem.title = "First"
        tab1Coordinator = CoordinatorFactory.makeTab1Coordinator(navigationController: firstNavController)
        tab1Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }

        let secondNavController = UINavigationController()
        secondNavController.tabBarItem.title = "Second"
        tab2Coordinator = CoordinatorFactory.makeTab2Coordinator(navigationController: secondNavController)
        tab2Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.finishFlow?()
        }
        
        tabBarController.viewControllers = [
            firstNavController,
            secondNavController
        ]

        tab1Coordinator.start()
    }
}

// MARK: - UITabBarControllerDelegate

extension TabBarCoordinator: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch tabBarController.selectedIndex {
        case 0:
            tab1Coordinator.start()
        case 1:
            tab2Coordinator.start()
        default:
            break
        }
    }
}
