//
//  UIViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

extension UIViewController {
    func setBackButtonTitle(_ title: String = "") {
        navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
    }
    
    func unsetBackButton() {
        navigationItem.hidesBackButton = true
    }
}

extension UIViewController {
    func setBackgroundTintColor() {
        view?.backgroundColor = Resources.Colors.tint.color
    }
}
