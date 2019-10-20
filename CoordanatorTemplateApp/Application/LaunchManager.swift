//
//  LaunchManager.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import Foundation

protocol LaunchManager: AnyObject {
    var flow: AppFlow { get }
    func update(isAuthorized: Bool)
}

final class LaunchManagerImpl: LaunchManager {
    
    private (set) var flow: AppFlow = .auth
    
    func update(isAuthorized: Bool) {
        if isAuthorized {
            flow = .main
        } else {
            flow = .auth
        }
    }
    
}
