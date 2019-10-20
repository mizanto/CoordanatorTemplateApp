//
//  Router.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

protocol Router {
    func present(_ viewController: UIViewController?)
    func present(_ viewController: UIViewController?, animated: Bool)
    
    func push(_ viewController: UIViewController?)
    func push(_ viewController: UIViewController?, hideBottomBar: Bool)
    func push(_ viewController: UIViewController?, animated: Bool)
    func push(_ viewController: UIViewController?, animated: Bool, completion: (() -> Void)?)
    func push(_ viewController: UIViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?)
    
    func popViewController()
    func popViewController(animated: Bool)
    
    func dismissViewController()
    func dismissViewController(animated: Bool, completion: (() -> Void)?)
    
    func setRootViewController(_ viewController: UIViewController?)
    func setRootViewController(_ viewController: UIViewController?, hideBar: Bool)
    func cleanRootController()
    
    func popToRootViewController(animated: Bool)
}

final class RouterImpl: Router {
    
    weak var rootController: UINavigationController?
    private var completions: [UIViewController : () -> Void]
    
    init(rootController: UINavigationController = UINavigationController()) {
        self.rootController = rootController
        completions = [:]
    }
    
    func present(_ viewController: UIViewController?) {
        present(viewController, animated: true)
    }
    
    func present(_ viewController: UIViewController?, animated: Bool) {
        guard let viewController = viewController else { return }
        rootController?.present(viewController, animated: animated, completion: nil)
    }
    
    func dismissViewController() {
        dismissViewController(animated: true, completion: nil)
    }
    
    func dismissViewController(animated: Bool, completion: (() -> Void)?) {
        rootController?.dismiss(animated: animated, completion: completion)
    }
    
    func push(_ viewController: UIViewController?) {
        push(viewController, animated: true)
    }
    
    func push(_ viewController: UIViewController?, hideBottomBar: Bool) {
        push(viewController, animated: true, hideBottomBar: hideBottomBar, completion: nil)
    }
    
    func push(_ viewController: UIViewController?, animated: Bool) {
        push(viewController, animated: animated, completion: nil)
    }
    
    func push(_ viewController: UIViewController?, animated: Bool, completion: (() -> Void)?) {
        push(viewController, animated: animated, hideBottomBar: false, completion: completion)
    }
    
    func push(_ viewController: UIViewController?, animated: Bool, hideBottomBar: Bool, completion: (() -> Void)?) {
        guard
            let viewController = viewController,
            (viewController is UINavigationController == false)
            else { assertionFailure("Deprecated push UINavigationController."); return }
        
        if let completion = completion {
            completions[viewController] = completion
        }
        viewController.hidesBottomBarWhenPushed = hideBottomBar
        rootController?.pushViewController(viewController, animated: animated)
    }
    
    func popViewController() {
        popViewController(animated: true)
    }
    
    func popViewController(animated: Bool) {
        if let viewController = rootController?.popViewController(animated: animated) {
            runCompletion(for: viewController)
        }
    }
    
    func setRootViewController(_ viewController: UIViewController?) {
        setRootViewController(viewController, hideBar: false)
    }
    
    func setRootViewController(_ viewController: UIViewController?, hideBar: Bool) {
        guard let viewController = viewController else { return }
        rootController?.setViewControllers([viewController], animated: false)
        rootController?.isNavigationBarHidden = hideBar
    }

    func cleanRootController() {
        rootController?.setViewControllers([], animated: false)
    }
    
    func popToRootViewController(animated: Bool) {
        if let viewControllers = rootController?.popToRootViewController(animated: animated) {
            viewControllers.forEach { viewController in
                runCompletion(for: viewController)
            }
        }
    }
    
    private func runCompletion(for controller: UIViewController) {
        guard let completion = completions[controller] else { return }
        completion()
        completions.removeValue(forKey: controller)
    }
    
}

