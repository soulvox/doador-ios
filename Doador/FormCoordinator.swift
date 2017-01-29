//
//  FormCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class FormCoordinator {
    
    fileprivate var navigationController: UINavigationController?
    fileprivate let personalDataViewController: PersonalDataViewController
    fileprivate var voiceDataViewController: VoiceDataViewController?
    fileprivate var contactDataViewController: ContactDataViewController?
    
    fileprivate var personalData: PersonalData?
    fileprivate var voiceData: VoiceData?
    fileprivate var contactData: ContactData?
    
    fileprivate var recordAudioCoordinator: RecordAudioCoordinator?
    
    init(navigationController: UINavigationController) {
        self.personalDataViewController = PersonalDataViewController()
        self.navigationController = navigationController
        self.navigationController?.pushViewController(personalDataViewController, animated: false)
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
        self.navigationController?.pushViewController(voiceDataViewController!, animated: true)
    }
}

extension FormCoordinator: VoiceDataViewControllerDelegate {
    func submit(voiceData: VoiceData) {
        self.voiceData = voiceData
        self.contactDataViewController = ContactDataViewController()
        self.contactDataViewController?.delegate = self
        self.navigationController?.pushViewController(contactDataViewController!, animated: true)
    }
}

extension FormCoordinator: ContactDataViewControllerDelegate {
    func submit(contactData: ContactData) {
        self.contactData = contactData
        
        guard let personalData = personalData,
            let voiceData = voiceData else { return }
        
        self.recordAudioCoordinator = RecordAudioCoordinator()

        guard let recordAudioViewController = recordAudioCoordinator?.viewController else { return }
        
        self.navigationController?.show(recordAudioViewController, sender: nil)
    }
}
