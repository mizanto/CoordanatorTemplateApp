//
//  ApplicationCoordinatorFactory.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

protocol ApplicationCoordinatorFactory {
    func makeFlow1Coordinator(router: Router, factory: ApplicationCoordinatorFactory) -> Coordinator  & Flow1Output
    func makeFlow2TabBarCoordinator(tabBarController: TabBarControllerCoordinatable, factory: ApplicationCoordinatorFactory) -> Coordinator & TabBarCoordinatorOutput
    
    func makeTab1Coordinator(router: Router, factory: ApplicationCoordinatorFactory) -> Coordinator & Tab1CoordinatorOutput
    func makeTab2Coordinator(router: Router, factory: ApplicationCoordinatorFactory) -> Coordinator & Tab2CoordinatorOutput
}

final class ApplicationCoordinatorFactoryImpl: ApplicationCoordinatorFactory {
    
    func makeFlow1Coordinator(router: Router, factory: ApplicationCoordinatorFactory) -> Coordinator & Flow1Output {
        return Flow1Coordinator(router: router, factory: factory)
    }
    
    func makeFlow2TabBarCoordinator(tabBarController: TabBarControllerCoordinatable, factory: ApplicationCoordinatorFactory) -> Coordinator & TabBarCoordinatorOutput {
        return TabBarCoordinator(tabBarController: tabBarController, factory: factory)
    }
    
    func makeTab1Coordinator(router: Router, factory: ApplicationCoordinatorFactory) -> Coordinator & Tab1CoordinatorOutput {
        return Tab1Coordinator(router: router, factory: factory)
    }
    
    func makeTab2Coordinator(router: Router, factory: ApplicationCoordinatorFactory) -> Coordinator & Tab2CoordinatorOutput {
        return Tab2Coordinator(router: router, factory: factory)
    }

}
