//
//  FormCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class FormCoordinator {
    
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let personalDataViewController: PersonalDataViewController
    fileprivate var voiceDataViewController: VoiceDataViewController?
    fileprivate var contactDataViewController: ContactDataViewController?
    
    fileprivate var personalData: PersonalData?
    fileprivate var voiceData: VoiceData?
    fileprivate var contactData: ContactData?
    
    fileprivate var recordAudioCoordinator: RecordAudioCoordinator?
    
    init(navigationController: UINavigationController?) {
        self.personalDataViewController = PersonalDataViewController()
        self.navigationController = navigationController
        self.personalDataViewController.delegate = self
    }
    
    func showViewController() {
        self.navigationController?.pushViewController(personalDataViewController, animated: true)
    }
}

extension FormCoordinator: PersonalDataViewControllerDelegate {
    func dismissPersonalDataViewController() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func submit(personalData: PersonalData) {
        self.personalData = personalData
        
        if self.voiceDataViewController == nil {
            self.voiceDataViewController = VoiceDataViewController()
            self.voiceDataViewController?.delegate = self
        }
        
        self.navigationController?.pushViewController(voiceDataViewController!, animated: true)
    }
}

extension FormCoordinator: VoiceDataViewControllerDelegate {
    func submit(voiceData: VoiceData) {
        self.voiceData = voiceData
        
        if self.contactDataViewController == nil {
            self.contactDataViewController = ContactDataViewController()
            self.contactDataViewController?.delegate = self
        }
        
        self.navigationController?.pushViewController(contactDataViewController!, animated: true)
    }
}

extension FormCoordinator: ContactDataViewControllerDelegate {
    func submit(contactData: ContactData) {
        self.contactData = contactData
        
        guard let personalData = personalData,
            let voiceData = voiceData else { return }
        
        self.recordAudioCoordinator = RecordAudioCoordinator(navigationController: navigationController)
        self.recordAudioCoordinator?.showViewController()
    }
}
