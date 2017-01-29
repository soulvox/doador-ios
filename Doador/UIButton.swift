//
//  UIButton.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

extension UIButton {
    static var actionButton: UIButton {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.borderColor = Resources.Colors.white.color.cgColor
        button.layer.masksToBounds = false
        button.layer.borderWidth = 1.0
        button.layer.cornerRadius = 5.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 12
        button.layer.shadowOpacity = 0.8
        button.backgroundColor = Resources.Colors.white.color
        
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        
        return button
    }
}
