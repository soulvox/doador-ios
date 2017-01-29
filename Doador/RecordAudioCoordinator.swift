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
    
    var viewController: UIViewController {
        return recordAudioViewController
    }
    
    fileprivate let recordAudioViewController: RecordAudioViewController
    fileprivate let audioRecorder: AudioRecorder
    fileprivate let playbackController: PlaybackController
    
    init() {
        self.audioRecorder = AudioRecorder()
        self.playbackController = PlaybackController()
        self.recordAudioViewController = RecordAudioViewController(audioRecorder: audioRecorder, playbackController: playbackController)
    }
}
