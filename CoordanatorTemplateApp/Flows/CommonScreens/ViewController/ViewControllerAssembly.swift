//
//  ViewControllerAssembly.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

/// Every screen have own factory that builds screen and hides it under UIViewController.
final class ViewControllerAssembly {
    
    /// Inside it's possible to use MVC/MVP/MVVM/VIPER architecture, outside it's just UIViewController.
    static func build(buttonTitle: String, completion: @escaping VoidClosure) -> UIViewController {
        let vc = ViewController()
        vc.buttonTitle = buttonTitle
        vc.buttonAction = completion
        return vc
    }
    
}
