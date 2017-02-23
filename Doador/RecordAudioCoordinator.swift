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
    fileprivate let flow: Flow
    fileprivate let sentencesRecordAudioViewController: RecordAudioViewController
    fileprivate var vowelsRecordAudioViewController: RecordAudioViewController?
    
    fileprivate var acknowledgmentCoordinator: AcknowledgmentCoordinator?
    
    init(navigationController: UINavigationController?, flow: Flow) {
        self.navigationController = navigationController
        self.flow = flow
        
        let description: String
        let textToRecord: String
        
        switch flow {
        case .donateVoice:
            description = Resources.Text.recordSentencesDescription.rawValue
            textToRecord = Resources.Text.sentencesToRecord.rawValue
            
        case .findDonator:
            description = Resources.Text.findDonatorRecordSentencesDescription.rawValue
            textToRecord = ""
        }
        
        self.sentencesRecordAudioViewController =
            RecordAudioViewController(
                audioRecorder: AudioRecorder(),
                playbackController: PlaybackController(),
                descriptionLabelText: description,
                textToRecordLabelText: textToRecord
        )
        
        self.sentencesRecordAudioViewController.delegate = self
    }
    
    func showViewController() {
        self.navigationController?.show(sentencesRecordAudioViewController, sender: nil)
    }
}

extension RecordAudioCoordinator: RecordAudioViewControllerDelegate {
    func submit(recordAudioViewController: RecordAudioViewController, recordedAudioUrl: URL) {
        switch flow {
        case .donateVoice:
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
                    self.acknowledgmentCoordinator = AcknowledgmentCoordinator(navigationController: navigationController, flow: flow)
                }
                
                self.acknowledgmentCoordinator?.showViewController()
            }
            
        case .findDonator:
            if self.acknowledgmentCoordinator == nil {
                self.acknowledgmentCoordinator = AcknowledgmentCoordinator(navigationController: navigationController, flow: flow)
            }
            
            self.acknowledgmentCoordinator?.showViewController()
        }
    }
}
