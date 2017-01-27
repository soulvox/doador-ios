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
    var navigationController: UINavigationController?
    
    init() {
        let donatorTypeViewController = DonatorTypeViewController()
        self.rootViewController = donatorTypeViewController
        donatorTypeViewController.delegate = self
    }
}

extension AppCoordinator: DonatorTypeViewControllerDelegate {
    func donateVoice() {
        let formViewController = FormViewController()
        formViewController.delegate = self
        
        self.navigationController = UINavigationController(rootViewController: formViewController)
        self.rootViewController.show(navigationController!, sender: nil)
    }
}

extension AppCoordinator: FormViewControllerDelegate {
    func cancel() {
        // TODO: Fix this smelly thing
        self.navigationController?.viewControllers.first?.dismiss(animated: true, completion: nil)
    }
    
    func submit(user: User) {
        let audioRecorder = AudioRecorder()
        let playbackController = PlaybackController()
        let recordAudioViewController = RecordAudioViewController(audioRecorder: audioRecorder, playbackController: playbackController)
        audioRecorder.delegate = recordAudioViewController
        self.navigationController?.pushViewController(recordAudioViewController, animated: true)
    }
}
