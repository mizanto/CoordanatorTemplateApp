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

final class Flow1Coordinator: BaseCoordinator, Flow1Output {

    var flowComplition: VoidClosure?
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
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
        navigationController.setViewControllers([vc], animated: false)
    }
}
