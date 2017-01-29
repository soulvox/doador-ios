//
//  FormCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol FormCoordinatorDelegate: class {
    func submit(personalData: PersonalData, voiceData: VoiceData, contactData: ContactData)
}

final class FormCoordinator {
    
    var viewController: UIViewController {
        return personalDataViewController
    }
    
    weak var delegate: FormCoordinatorDelegate?
    
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let personalDataViewController: PersonalDataViewController
    fileprivate var voiceDataViewController: VoiceDataViewController?
    fileprivate var contactDataViewController: ContactDataViewController?
    
    fileprivate var personalData: PersonalData?
    fileprivate var voiceData: VoiceData?
    fileprivate var contactData: ContactData?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.personalDataViewController = PersonalDataViewController()
        self.personalDataViewController.delegate = self
    }
}

extension FormCoordinator: PersonalDataViewControllerDelegate {
    func dismissPersonalDataViewController() {
        self.personalDataViewController.dismiss(animated: true, completion: nil)
    }
    
    func submit(personalData: PersonalData) {
        self.personalData = personalData
        self.voiceDataViewController = VoiceDataViewController()
        self.voiceDataViewController?.delegate = self
        self.navigationController?.show(voiceDataViewController!, sender: nil)
    }
}

extension FormCoordinator: VoiceDataViewControllerDelegate {
    func dismissVoiceDataViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func submit(voiceData: VoiceData) {
        self.voiceData = voiceData
        self.contactDataViewController = ContactDataViewController()
        self.contactDataViewController?.delegate = self
        self.navigationController?.show(contactDataViewController!, sender: nil)
    }
}

extension FormCoordinator: ContactDataViewControllerDelegate {
    func dismissContactDataViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func submit(contactData: ContactData) {
        self.contactData = contactData
        
        guard let personalData = personalData,
            let voiceData = voiceData else { return }
        
        delegate?.submit(personalData: personalData, voiceData: voiceData, contactData: contactData)
    }
}
