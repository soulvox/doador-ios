//
//  FindDonatorCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 22/02/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class FindDonatorCoordinator {
    
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let findDonatorTermsViewController: FindDonatorTermsViewController
    
    fileprivate var formCoordinator: FormCoordinator?
    
    init(navigationController: UINavigationController?) {
        self.findDonatorTermsViewController = FindDonatorTermsViewController()
        self.navigationController = navigationController
        self.navigationController?.pushViewController(findDonatorTermsViewController, animated: false)
        self.findDonatorTermsViewController.delegate = self
    }
}

extension FindDonatorCoordinator: FindDonatorTermsViewControllerDelegate {
    func dismissFindDonatorTermsViewController() {
        self.findDonatorTermsViewController.dismiss(animated: true, completion: nil)
    }
    
    func acceptTerms() {
        if self.formCoordinator == nil {
            self.formCoordinator = FormCoordinator(navigationController: navigationController, flow: .findDonator)
        }
        
        self.formCoordinator?.showViewController()
    }
}

