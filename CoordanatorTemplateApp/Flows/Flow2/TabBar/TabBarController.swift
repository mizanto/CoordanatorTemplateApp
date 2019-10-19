//
//  TabBarController.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

typealias TabSelectionHandler = (UIViewController) -> ()

protocol TabBarControllerCoordinatable {
    
    var onFirstTabSelect: TabSelectionHandler? { get set }
    var onSecondTabSelect: TabSelectionHandler? { get set }
    
    // после создания нужно обязательно выставить соответствующие контроллеры
    func setup(firstRootController: UIViewController,
               secondRootController: UIViewController)
    
}

final class TabBarController: UITabBarController, TabBarControllerCoordinatable {
    
    private var firstRootController: UIViewController!
    private var secondRootController: UIViewController!
    
    var onFirstTabSelect: TabSelectionHandler?
    var onSecondTabSelect: TabSelectionHandler?
    
    func setup(firstRootController: UIViewController, secondRootController: UIViewController) {
        self.firstRootController = firstRootController
        self.secondRootController = secondRootController
        
        setRootViewControllers()
        setupTabs()
    }
    
    private func setRootViewControllers() {
        viewControllers = [
            firstRootController,
            secondRootController
        ]
    }
    
    private func setupTabs() {
        firstRootController.tabBarItem.title = "First"
        secondRootController.tabBarItem.title = "Second"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        onFirstTabSelect?(firstRootController)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        switch viewController {
        case firstRootController:
            onFirstTabSelect?(viewController)
        case secondRootController:
            onSecondTabSelect?(viewController)
        default:
            assertionFailure("Unknown controller did select in tab")
        }
    }
    
}

