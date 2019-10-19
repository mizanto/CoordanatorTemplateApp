//
//  TabBarAssembly.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

final class TabBarAssembly {
    
    static func build() -> UIViewController & TabBarControllerCoordinatable {
        let tabBatController = TabBarController()
        return tabBatController
    }
    
}
