//
//  TabBarCoordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

typealias VoidClosure = () -> ()

protocol TabBarCoordinatorOutput: class {
    var finishFlow: VoidClosure? { get set }
}

final class TabBarCoordinator: BaseCoordinator & TabBarCoordinatorOutput {
    
    var finishFlow: VoidClosure?
    
    private let factory: ApplicationCoordinatorFactory
    private var tabBarController: TabBarControllerCoordinatable
    
    private var tab1Coordinator: (Coordinator & Tab1CoordinatorOutput)!
    private var tab2Coordinator: (Coordinator & Tab2CoordinatorOutput)!
    
    init(tabBarController: TabBarControllerCoordinatable,
         factory: ApplicationCoordinatorFactory = ApplicationCoordinatorFactoryImpl()) {

        self.tabBarController = tabBarController
        self.factory = factory
        super.init()
    }
    
    override func start() {
        let firstNavController = UINavigationController()
        let firstRouter = RouterImpl(rootController: firstNavController)
        tab1Coordinator = factory.makeTab1Coordinator(router: firstRouter, factory: factory)
        tab1Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(self.tab1Coordinator)
            self.removeDependency(self.tab2Coordinator)
            self.finishFlow?()
        }

        let secondNavController = UINavigationController()
        let secondRouter = RouterImpl(rootController: secondNavController)
        tab2Coordinator = factory.makeTab2Coordinator(router: secondRouter, factory: factory)
        tab2Coordinator.finishFlow = { [weak self] in
            guard let self = self else { return }
            self.removeDependency(self.tab1Coordinator)
            self.removeDependency(self.tab2Coordinator)
            self.finishFlow?()
        }
        
        tabBarController.setup(firstRootController: firstNavController,
                               secondRootController: secondNavController)
        
        tabBarController.onFirstTabSelect = makeTab1Flow(with: tab1Coordinator)
        tabBarController.onSecondTabSelect = makeTab2Flow(with: tab2Coordinator)
    }
    
    private func makeTab1Flow(with coordinator: Coordinator) -> TabSelectionHandler {
        return { [weak self, weak coordinator] vc in
            guard
                let navController = vc as? UINavigationController,
                let coordinator = coordinator,
                let self = self else {
                    return
            }
            
            if navController.viewControllers.isEmpty {
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
    private func makeTab2Flow(with coordinator: Coordinator) -> TabSelectionHandler {
        return { [weak self, weak coordinator] vc in
            guard
                let navController = vc as? UINavigationController,
                let coordinator = coordinator,
                let self = self else {
                    return
            }
            
            if navController.viewControllers.isEmpty {
                self.addDependency(coordinator)
                coordinator.start()
            }
        }
    }
    
}
