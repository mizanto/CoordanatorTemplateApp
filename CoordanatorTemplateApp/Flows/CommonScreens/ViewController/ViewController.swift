//
//  ViewController.swift
//  CoordanatorTemplateApp
//
//  Created by sergey.bendak on 10/19/19.
//  Copyright © 2019 sb. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var buttonTitle: String? {
        set { button.setTitle(newValue, for: .normal) }
        get { return button.title(for: .normal) }
    }
    
    var buttonAction: VoidClosure?
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Button", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(buttonTapAction), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUi()
    }
    
    private func setupUi() {
        view.backgroundColor = .white
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate(
            [
                button.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ]
        )
    }

    @objc
    private func buttonTapAction() {
        buttonAction?()
    }
    
}

