//
//  Flow1Coordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import Foundation

protocol Flow1Output {
    var flowComplition: VoidClosure? { get set }
}

final class Flow1Coordinator: BaseCoordinator, Flow1Output {
    
    var flowComplition: VoidClosure?
    
    private let router: Router
    private let factory: ApplicationCoordinatorFactory
    
    init(router: Router,
         factory: ApplicationCoordinatorFactory = ApplicationCoordinatorFactoryImpl()) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showScreen()
    }
    
    private func showScreen() {
        let vc = ViewControllerAssembly.build(
            buttonTitle: "Next Flow",
            completion: { [weak self] in
                guard let self = self else { return }
                self.flowComplition?()
            }
        )
        router.setRootViewController(vc)
    }
    
}
