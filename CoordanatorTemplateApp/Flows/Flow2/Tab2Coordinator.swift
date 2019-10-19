//
//  Tab2Coordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import Foundation

protocol Tab2CoordinatorOutput {
    var finishFlow: VoidClosure? { get set }
}

final class Tab2Coordinator: BaseCoordinator, Tab2CoordinatorOutput {
    
    var finishFlow: VoidClosure?
    
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
            buttonTitle: "Finish Flow",
            completion: { [weak self] in
                guard let self = self else { return }
                self.finishFlow?()
            }
        )
        vc.title = "Tab 2 Title"
        router.setRootViewController(vc)
    }
    
}
