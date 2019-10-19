//
//  ViewControllerAssembly.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

final class ViewControllerAssembly {
    
    static func build(buttonTitle: String, completion: @escaping VoidClosure) -> UIViewController {
        let vc = ViewController()
        vc.buttonTitle = buttonTitle
        vc.buttonAction = completion
        return vc
    }
    
}
