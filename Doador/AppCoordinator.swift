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
    let navigationController: UINavigationController
    
    fileprivate var formCoordinator: FormCoordinator?
    fileprivate var recordAudioCoordinator: RecordAudioCoordinator?
    
    init() {
        let mainViewController = MainViewController()
        self.rootViewController = mainViewController
        self.navigationController = UINavigationController()
        mainViewController.delegate = self
    }
}

extension AppCoordinator: MainViewControllerDelegate {
    func donateVoice() {
        self.formCoordinator = FormCoordinator(navigationController: navigationController)
        self.rootViewController.show(navigationController, sender: nil)
    }
    
    func findDonator() {
        
    }
}
