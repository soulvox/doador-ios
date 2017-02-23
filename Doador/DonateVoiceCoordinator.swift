//
//  DonateVoiceCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class DonateVoiceCoordinator {
    
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let donateVoiceTermsViewController: DonateVoiceTermsViewController
    
    fileprivate var formCoordinator: FormCoordinator?
    
    init(navigationController: UINavigationController?) {
        self.donateVoiceTermsViewController = DonateVoiceTermsViewController()
        self.navigationController = navigationController
        self.navigationController?.pushViewController(donateVoiceTermsViewController, animated: false)
        self.donateVoiceTermsViewController.delegate = self
    }
}

extension DonateVoiceCoordinator: DonateVoiceTermsViewControllerDelegate {
    func dismissDonateVoiceTermsViewController() {
        self.donateVoiceTermsViewController.dismiss(animated: true, completion: nil)
    }
    
    func acceptTerms() {
        if self.formCoordinator == nil {
            self.formCoordinator = FormCoordinator(navigationController: navigationController, flow: .donateVoice)
        }
        
        self.formCoordinator?.showViewController()
    }
}
