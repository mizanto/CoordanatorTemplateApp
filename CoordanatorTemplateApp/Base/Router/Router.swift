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

