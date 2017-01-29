//
//  AcknowledgmentCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class AcknowledgmentCoordinator {
    
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let acknowledgmentViewController: AcknowledgmentViewController
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.acknowledgmentViewController = AcknowledgmentViewController()
        self.acknowledgmentViewController.delegate = self
    }
    
    func showViewController() {
        self.navigationController?.show(acknowledgmentViewController, sender: nil)
    }
}

extension AcknowledgmentCoordinator: AcknowledgmentViewControllerDelegate {
    func startOver() {
        _ = self.acknowledgmentViewController.dismiss(animated: true, completion: nil)
    }
}
