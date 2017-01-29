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
    fileprivate let sentencesRecordAudioViewController: RecordAudioViewController
    fileprivate var vowelsRecordAudioViewController: RecordAudioViewController?
    
    fileprivate var acknowledgmentCoordinator: AcknowledgmentCoordinator?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
        
        self.sentencesRecordAudioViewController =
            RecordAudioViewController(
                audioRecorder: AudioRecorder(),
                playbackController: PlaybackController(),
                descriptionLabelText: Resources.Text.recordSentencesDescription.rawValue,
                textToRecordLabelText: Resources.Text.sentencesToRecord.rawValue)
        
        self.sentencesRecordAudioViewController.delegate = self
    }
    
    func showViewController() {
        self.navigationController?.show(sentencesRecordAudioViewController, sender: nil)
    }
}

extension RecordAudioCoordinator: RecordAudioViewControllerDelegate {
    func submit(recordAudioViewController: RecordAudioViewController, recordedAudioUrl: URL) {
        if recordAudioViewController === self.sentencesRecordAudioViewController {
            
            if self.vowelsRecordAudioViewController == nil {
                self.vowelsRecordAudioViewController =
                    RecordAudioViewController(
                        audioRecorder: AudioRecorder(),
                        playbackController: PlaybackController(),
                        descriptionLabelText: Resources.Text.recordVowelsDescription.rawValue,
                        textToRecordLabelText: Resources.Text.vowelsToRecord.rawValue)
                
                self.vowelsRecordAudioViewController?.delegate = self
            }
            
            self.navigationController?.show(vowelsRecordAudioViewController!, sender: nil)
        
        } else if recordAudioViewController === self.vowelsRecordAudioViewController {
            if self.acknowledgmentCoordinator == nil {
                self.acknowledgmentCoordinator = AcknowledgmentCoordinator(navigationController: navigationController)
            }
            
            self.acknowledgmentCoordinator?.showViewController()
        }
    }
}
