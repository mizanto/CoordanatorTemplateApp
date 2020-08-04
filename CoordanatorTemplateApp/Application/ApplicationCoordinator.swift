//
//  ApplicationCoordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

final class ApplicationCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let coordinatorFactory: CoordinatorFactory
    private let router: Router
    private let launchManager: LaunchManager
    
    private var window: UIWindow
    
    init(window: UIWindow,
         router: Router,
         launchManager: LaunchManager,
         factory: CoordinatorFactory) {
        self.router = router
        self.window = window
        self.launchManager = launchManager
        self.coordinatorFactory = factory
    }
    
    func start() {
        window.makeKeyAndVisible()
        
        launchManager.update(isAuthorized: false)
        
        runRootFlow()
    }
    
    private func runRootFlow() {
        switch launchManager.flow {
        case .auth:
            runFlow1()
        case .main:
            runFlow2()
        }
    }
    
    private func runFlow1() {
        let navController = UINavigationController()
        var coordinator = coordinatorFactory.makeFlow1Coordinator(
            router: RouterImpl(rootController: navController),
            factory: coordinatorFactory
        )
        coordinator.flowComplition = { [weak self, weak coordinator] in
            guard let self = self, let coordinator = coordinator else { return }
            self.removeDependency(coordinator)
            self.launchManager.update(isAuthorized: true)
            self.runRootFlow()
        }
        addDependency(coordinator)
        coordinator.start()
        window.rootViewController = navController
    }
    
    private func runFlow2() {
        let tabBarController = UITabBarController()
        let tabBarCoordinator = coordinatorFactory.makeFlow2TabBarCoordinator(
            tabBarController:tabBarController,
            factory: coordinatorFactory
        )
        tabBarCoordinator.finishFlow = { [weak self, weak tabBarCoordinator] in
            guard let self = self, let coordinator = tabBarCoordinator else { return }
            self.removeDependency(coordinator)
            self.launchManager.update(isAuthorized: false)
            self.runRootFlow()
        }
        addDependency(tabBarCoordinator)
        tabBarCoordinator.start()
        window.rootViewController = tabBarController
    }
    
}
