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
    
    fileprivate let recordButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Gravar", for: .normal)
        button.setTitle("Parar", for: .selected)
        button.addTarget(self, action: #selector(toggleRecordStop), for: .touchUpInside)
        return button
    }()
    
    fileprivate let playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Tocar", for: .normal)
        button.setTitle("Pausar", for: .selected)
        button.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        return button
    }()
    
    fileprivate var recordState: RecordState = .stopped {
        didSet {
            recordStateDidChange()
        }
    }
    
    fileprivate let audioRecorder: AudioRecorder
    fileprivate let playbackController: PlaybackController
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(audioRecorder: AudioRecorder, playbackController: PlaybackController) {
        self.audioRecorder = audioRecorder
        self.playbackController = playbackController
        super.init(nibName: nil, bundle: nil)
        
        self.audioRecorder.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupAppearance()
        setupPlaybackController()
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
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.tint.color
    }
    
    private func setupPlaybackController() {
        let center = NotificationCenter.default
        
        center.addObserver(
            forName: PlaybackControllerNotification.didUpdateStatus.name,
            object: playbackController,
            queue: .main) { [weak self] _ in
                
                guard let this = self else { return }
                
                switch this.playbackController.status {
                case .idle, .preparing(_, _), .paused(_), .buffering:
                    this.playButton.isSelected = false
                    this.playButton.isEnabled = true
                    this.recordButton.isEnabled = true
                    
                case .playing(_):
                    this.playButton.isSelected = true
                    this.playButton.isEnabled = true
                    this.recordButton.isEnabled = false
                    
                case .error(let error):
                    print("Error during playback: \(error)")
                    this.playButton.isSelected = false
                    this.playButton.isEnabled = false
                    this.recordButton.isEnabled = true
                }
        }
    }
    
    @objc private func toggleRecordStop() {
        switch playbackController.status {
        case .playing(_), .buffering:
            playbackController.pause(manually: true)
            
        default:
            break
        }
        
        switch recordState {
        case .recording:
            audioRecorder.finishRecording()
            
        case .stopped:
            audioRecorder.startRecording()
        }
    }
    
    @objc private func togglePlayPause() {
        switch recordState {
        case .recording:
            audioRecorder.finishRecording()
            
        case .stopped:
            break
        }
        
        playbackController.togglePlayPause()
    }
    
    private func recordStateDidChange() {
        switch recordState {
        case .recording:
            recordButton.isSelected = true
            
        case .stopped:
            recordButton.isSelected = false
        }
    }
}

extension RecordAudioViewController: AudioRecorderDelegate {
    func onStartRecording(success: Bool) {
        if success {
            recordState = .recording
            playButton.isEnabled = false
        
        } else {
            recordState = .stopped
            playButton.isEnabled = true
        }
    }
    
    func onFinishRecording(success: Bool, url: URL?) {
        recordState = .stopped
        playButton.isEnabled = true

        if success {
            guard let url = url else { return }
            
            let nowPlayingInfo = PlaybackSource.NowPlayingInfo(title: "", albumTitle: "", artist: "", artworkUrl: nil)
            let playbackSource = PlaybackSource(url: url, type: .audio(nowPlayingInfo: nowPlayingInfo))
            playbackController.prepareToPlay(playbackSource)
        }
    }
}
