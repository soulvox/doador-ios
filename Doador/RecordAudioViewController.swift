//
//  RecordAudioViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import Keith

final class RecordAudioViewController: UIViewController {
    
    enum RecordState {
        case recording, stopped
    }
    
    enum PlayState {
        case playing, paused, stopped
    }
    
    private let recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Gravar", for: .normal)
        button.setTitle("Parar", for: .selected)
        button.addTarget(self, action: #selector(RecordAudioViewController.toggleRecordStop), for: .touchUpInside)
        return button
    }()
    
    private let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tocar", for: .normal)
        button.setTitle("Pausar", for: .selected)
        button.addTarget(self, action: #selector(RecordAudioViewController.toggleRecordStop), for: .touchUpInside)
        return button
    }()
    
    fileprivate var recordState: RecordState = .stopped {
        didSet {
            recordStateDidChange()
        }
    }
    
    fileprivate var playState: PlayState = .paused {
        didSet {
            playStateDidChange()
        }
    }
    
    private let audioRecorder: AudioRecorder
    fileprivate let playbackController: PlaybackController
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(audioRecorder: AudioRecorder, playbackController: PlaybackController) {
        self.audioRecorder = audioRecorder
        self.playbackController = playbackController
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(recordButton)
        view.addSubview(playButton)
        
        recordButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.translatesAutoresizingMaskIntoConstraints = false
        
        recordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        recordButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.topAnchor.constraint(equalTo: recordButton.bottomAnchor, constant: 20).isActive = true
    }
    
    @objc private func toggleRecordStop() {
        switch recordState {
        case .recording:
            recordState = .stopped
            
        case .stopped:
            recordState = .recording
        }
    }
    
    @objc private func togglePlayPause() {
        switch playState {
        case .playing:
            playState = .paused
            
        case .stopped:
            playState = .playing
            
        case .paused:
            playState = .playing
        }
    }
    
    private func recordStateDidChange() {
        switch recordState {
        case .recording:
            playState = .stopped
            recordButton.isSelected = true
            audioRecorder.startRecording()
            
        case .stopped:
            recordButton.isSelected = false
            audioRecorder.finishRecording(success: true)
        }
    }
    
    private func playStateDidChange() {
        switch playState {
        case .playing:
            playButton.isSelected = true
            playbackController.play()
            
        case .stopped:
            playButton.isSelected = false
            playbackController.stop()
            
        case .paused:
            playButton.isSelected = false
            playbackController.pause(manually: true)
        }
    }
}

extension RecordAudioViewController: AudioRecorderDelegate {
    func onStartRecording(success: Bool) {
        if success {
            switch recordState {
            case .recording:
                recordState = .stopped
                
            case .stopped:
                recordState = .recording
                
            }
            
        } else {
            recordState = .stopped
        }
    }
    
    func onFinishRecording(success: Bool, url: URL?) {
        if success {
            guard let url = url else { return }
            
            let nowPlayingInfo = PlaybackSource.NowPlayingInfo(title: "", albumTitle: "", artist: "", artworkUrl: nil)
            let playbackSource = PlaybackSource(url: url, type: .audio(nowPlayingInfo: nowPlayingInfo))
            playbackController.prepareToPlay(playbackSource)
            
        }
    }
}
