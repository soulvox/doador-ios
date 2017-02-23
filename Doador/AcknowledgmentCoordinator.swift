//
//  AcknowledgmentCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class AcknowledgmentCoordinator {
    
    fileprivate let flow: Flow
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let acknowledgmentViewController: AcknowledgmentViewController
    
    init(navigationController: UINavigationController?, flow: Flow) {
        self.flow = flow
        self.navigationController = navigationController
        
        let text: String
        
        switch flow {
        case .donateVoice:
            text = Resources.Text.acknowledgment.rawValue
            
        case .findDonator:
            text = Resources.Text.findDonatorAcknowledgment.rawValue
        }
        
        self.acknowledgmentViewController = AcknowledgmentViewController(acknowledgmentLabelText: text)
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
