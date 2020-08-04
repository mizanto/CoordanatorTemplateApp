//
//  Flow1Coordinator.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import Foundation
import UIKit

/// Protocol helps pass data outside current coordinator and handle it in parent coordinator.
protocol Flow1Output {
    var flowComplition: VoidClosure? { get set }
}

final class Flow1Coordinator: Coordinator, Flow1Output {
    
    var childCoordinators: [Coordinator] = []
    
    var flowComplition: VoidClosure?
    
    private let navigationController: UINavigationController
    private let factory: CoordinatorFactory
    
    init(navigationController: UINavigationController,
         factory: CoordinatorFactory) {
        self.navigationController = navigationController
        self.factory = factory
    }
    
    func start() {
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
        navigationController.setViewControllers([vc], animated: false)
    }
}
