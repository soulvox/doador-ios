//
//  AppCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import Keith

final class AppCoordinator {
    let rootViewController: UIViewController
    
    fileprivate var navigationController: UINavigationController?
    fileprivate var formCoordinator: FormCoordinator?
    
    init() {
        let donatorTypeViewController = DonatorTypeViewController()
        self.rootViewController = donatorTypeViewController
        donatorTypeViewController.delegate = self
    }
}

extension AppCoordinator: DonatorTypeViewControllerDelegate {
    func donateVoice() {
        self.navigationController = UINavigationController()
        
        guard let navigationController = navigationController else { return }
        
        self.formCoordinator = FormCoordinator(navigationController: navigationController)
        let formViewController = formCoordinator?.viewController
        
        navigationController.show(formViewController!, sender: nil)
        self.rootViewController.show(navigationController, sender: nil)
    }
}
