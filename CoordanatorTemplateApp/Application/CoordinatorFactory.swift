//
//  CoordinatorFactory.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

protocol CoordinatorFactory {
    func makeFlow1Coordinator(navigationController: UINavigationController,
                              factory: CoordinatorFactory) -> Coordinator  & Flow1Output
    func makeFlow2TabBarCoordinator(tabBarController: UITabBarController,
                                    factory: CoordinatorFactory) -> Coordinator & TabBarCoordinatorOutput
    
    func makeTab1Coordinator(navigationController: UINavigationController,
                             factory: CoordinatorFactory) -> Coordinator & Tab1CoordinatorOutput
    func makeTab2Coordinator(navigationController: UINavigationController,
                             factory: CoordinatorFactory) -> Coordinator & Tab2CoordinatorOutput
}

final class CoordinatorFactoryImpl: CoordinatorFactory {
    
    func makeFlow1Coordinator(navigationController: UINavigationController,
                              factory: CoordinatorFactory) -> Coordinator & Flow1Output {
        return Flow1Coordinator(navigationController: navigationController, factory: factory)
    }
    
    func makeFlow2TabBarCoordinator(tabBarController: UITabBarController,
                                    factory: CoordinatorFactory) -> Coordinator & TabBarCoordinatorOutput {
        return TabBarCoordinator(tabBarController: tabBarController, factory: factory)
    }
    
    func makeTab1Coordinator(navigationController: UINavigationController,
                             factory: CoordinatorFactory) -> Coordinator & Tab1CoordinatorOutput {
        return Tab1Coordinator(navigationController: navigationController, factory: factory)
    }
    
    func makeTab2Coordinator(navigationController: UINavigationController,
                             factory: CoordinatorFactory) -> Coordinator & Tab2CoordinatorOutput {
        return Tab2Coordinator(navigationController: navigationController, factory: factory)
    }

}
