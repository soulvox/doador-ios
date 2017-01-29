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
    fileprivate var recordAudioCoordinator: RecordAudioCoordinator?
    
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
        self.formCoordinator?.delegate = self
        
        let formViewController = formCoordinator?.viewController
        
        navigationController.show(formViewController!, sender: nil)
        self.rootViewController.show(navigationController, sender: nil)
    }
}

extension AppCoordinator: FormCoordinatorDelegate {
    func submit(personalData: PersonalData, voiceData: VoiceData, contactData: ContactData) {
        self.recordAudioCoordinator = RecordAudioCoordinator()
        
        guard let recordAudioViewController = recordAudioCoordinator?.viewController else { return }
        
        self.navigationController?.show(recordAudioViewController, sender: nil)
    }
}
