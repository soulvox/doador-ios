//
//  RecordAudioCoordinator.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import Keith

final class RecordAudioCoordinator {
    
    fileprivate weak var navigationController: UINavigationController?
    fileprivate let audioRecorder: AudioRecorder
    fileprivate let playbackController: PlaybackController
    fileprivate let recordAudioViewController: RecordAudioViewController
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        self.audioRecorder = AudioRecorder()
        self.playbackController = PlaybackController()
        self.recordAudioViewController = RecordAudioViewController(audioRecorder: audioRecorder, playbackController: playbackController)
    }
    
    func showViewController() {
        self.navigationController?.show(recordAudioViewController, sender: nil)
    }
}
