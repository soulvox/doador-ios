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
    
    fileprivate var personalData: PersonalData?
    fileprivate var voiceData: VoiceData?
    
    fileprivate var recordAudioCoordinator: RecordAudioCoordinator?
    
    init(navigationController: UINavigationController?) {
        self.personalDataViewController = PersonalDataViewController(style: .grouped)
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
            self.voiceDataViewController = VoiceDataViewController(style: .grouped)
            self.voiceDataViewController?.delegate = self
        }
        
        self.navigationController?.pushViewController(voiceDataViewController!, animated: true)
    }
}

extension FormCoordinator: VoiceDataViewControllerDelegate {
    func submit(voiceData: VoiceData) {
        self.voiceData = voiceData
        
        if self.recordAudioCoordinator == nil {
            self.recordAudioCoordinator = RecordAudioCoordinator(navigationController: navigationController)
        }
        
        self.recordAudioCoordinator?.showViewController()
    }
}
