//
//  CoordinatorFactory.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

final class CoordinatorFactory {
    
    static func makeFlow1Coordinator(navigationController: UINavigationController) -> Coordinator & Flow1Output {
        return Flow1Coordinator(navigationController: navigationController)
    }
    
    static func makeFlow2TabBarCoordinator(tabBarController: UITabBarController) -> Coordinator & TabBarCoordinatorOutput {
        return TabBarCoordinator(tabBarController: tabBarController)
    }
    
    static func makeTab1Coordinator(navigationController: UINavigationController) -> Coordinator & Tab1CoordinatorOutput {
        return Tab1Coordinator(navigationController: navigationController)
    }
    
    static func makeTab2Coordinator(navigationController: UINavigationController) -> Coordinator & Tab2CoordinatorOutput {
        return Tab2Coordinator(navigationController: navigationController)
    }
    
}
