//
//  UIView.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

extension UIView {
    func pinToEdges(ofViewController viewController: UIViewController,
                    insets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: -20, right: -16)) {
        
        guard let view = viewController.view else { return }
        
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor, constant: insets.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        bottomAnchor.constraint(equalTo: viewController.bottomLayoutGuide.topAnchor, constant: insets.bottom).isActive = true
    }
    
    // Convenience for ignoring the bottom edge
    func pinToTopEdges(ofViewController viewController: UIViewController,
                       insets: UIEdgeInsets = UIEdgeInsets(top: 20, left: 16, bottom: 0, right: -16)) {
        
        guard let view = viewController.view else { return }
        
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: viewController.topLayoutGuide.bottomAnchor, constant: insets.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
    }
    
    func pinToEdges(ofView view: UIView,
                    insets: UIEdgeInsets = UIEdgeInsets(top: 10, left: 16, bottom: -10, right: -16)) {
        
        view.addSubview(self)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        topAnchor.constraint(equalTo: view.topAnchor, constant: insets.top).isActive = true
        leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: insets.left).isActive = true
        trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: insets.right).isActive = true
        bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: insets.bottom).isActive = true
    }
}
