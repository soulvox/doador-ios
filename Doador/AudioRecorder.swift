//
//  AudioRecorder.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation
import AVFoundation

protocol AudioRecorderDelegate: class {
    func onStartRecording(success: Bool)
    func onFinishRecording(success: Bool, url: URL?)
}

final class AudioRecorder: NSObject, AVAudioRecorderDelegate {
    
    weak var delegate: AudioRecorderDelegate?
    
    private let audioSession = AVAudioSession.sharedInstance()
    private var audioRecorder: AVAudioRecorder?

    func startRecording() {
        do {
            try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try audioSession.setActive(true)
            try audioSession.overrideOutputAudioPort(.speaker)
            
            audioSession.requestRecordPermission { [weak self] allowed in
                DispatchQueue.main.async {
                    guard let this = self else { return }
                    
                    if allowed {
                        this._startRecording()
                    
                    } else {
                        this.delegate?.onStartRecording(success: false)
                    }
                }
            }
        }
        catch {
            delegate?.onStartRecording(success: false)
        }
    }
    
    private func _startRecording() {
        let filename = UUID().uuidString + ".m4a"
        let audioUrl = documentsDirectory().appendingPathComponent(filename)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioUrl, settings: settings)
            audioRecorder?.delegate = self
            audioRecorder?.record()
            
            delegate?.onStartRecording(success: true)
        }
        catch {
            finishRecording()
            delegate?.onStartRecording(success: false)
        }
    }
    
    func finishRecording() {
        audioRecorder?.stop()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        delegate?.onFinishRecording(success: flag, url: recorder.url)
    }
    
    private func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
}
