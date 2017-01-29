//
//  RecordAudioViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import Keith

protocol RecordAudioViewControllerDelegate: class {
    func submit(recordAudioViewController: RecordAudioViewController, recordedAudioUrl: URL)
}

final class RecordAudioViewController: UIViewController, BackgroundColorable {
    
    enum RecordState {
        case recording, stopped
    }
    
    weak var delegate: RecordAudioViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel.descriptiveLabel
        return label
    }()
    
    private let textToRecordLabel: UILabel = {
        let label = UILabel.descriptiveLabel
        label.font = UIFont.boldSystemFont(ofSize: UIFont.preferredFont(forTextStyle: .body).pointSize)
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView.horizontalContainer
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 5
        return stackView
    }()
    
    fileprivate let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(Resources.Images.play.image, for: .normal)
        button.setImage(Resources.Images.pause.image, for: .selected)
        button.addTarget(self, action: #selector(togglePlayPause), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    fileprivate let recordButton: UIButton = {
        let button = UIButton(type: .custom)
        let image = Resources.Images.microphone.image
        button.setImage(Resources.Images.microphoneFilled.image, for: .normal)
        button.addTarget(self, action: #selector(toggleRecordStop), for: .touchUpInside)
        return button
    }()
    
    private lazy var continueButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(submit))
        button.isEnabled = false
        return button
    }()
    
    fileprivate var recordState: RecordState = .stopped {
        didSet {
            recordStateDidChange()
        }
    }
    
    fileprivate let audioRecorder: AudioRecorder
    fileprivate let playbackController: PlaybackController
    fileprivate var recordedAudioUrl: URL? {
        didSet {
            continueButton.isEnabled = recordedAudioUrl != nil
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(audioRecorder: AudioRecorder, playbackController: PlaybackController, descriptionLabelText: String, textToRecordLabelText: String) {
        self.audioRecorder = audioRecorder
        self.playbackController = playbackController
        self.descriptionLabel.text = descriptionLabelText
        self.textToRecordLabel.text = textToRecordLabelText
        
        super.init(nibName: nil, bundle: nil)
        
        self.audioRecorder.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setBackgroundTintColor()
        setupPlaybackController()
        setBackButtonTitle()
    }
    
    private func setupSubviews() {
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(recordButton)
        containerStackView.addArrangedSubview(descriptionLabel)
        containerStackView.addArrangedSubview(textToRecordLabel)
        containerStackView.addArrangedSubview(buttonsStackView)
        containerStackView.pinToEdges(ofViewController: self)
        
        playButton.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor, constant: -65).isActive = true
        recordButton.centerXAnchor.constraint(equalTo: buttonsStackView.centerXAnchor, constant: 65).isActive = true
        
        navigationItem.rightBarButtonItem = continueButton
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
    
    @objc private func submit() {
        guard let url = recordedAudioUrl else { return }
        delegate?.submit(recordAudioViewController: self, recordedAudioUrl: url)
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
            
            UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut, .repeat, .autoreverse, .allowUserInteraction], animations: { self.recordButton.alpha = 0.3 }, completion: nil)
        
        } else {
            recordState = .stopped
            playButton.isEnabled = true
        }
    }
    
    func onFinishRecording(success: Bool, url: URL?) {
        recordState = .stopped
        playButton.isEnabled = true
        
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseInOut, .beginFromCurrentState], animations: { self.recordButton.alpha = 1.0 }, completion: nil)

        if success {
            guard let url = url else { return }
            
            self.recordedAudioUrl = url
            
            let nowPlayingInfo = PlaybackSource.NowPlayingInfo(title: "", albumTitle: "", artist: "", artworkUrl: nil)
            let playbackSource = PlaybackSource(url: url, type: .audio(nowPlayingInfo: nowPlayingInfo))
            playbackController.prepareToPlay(playbackSource)
        }
    }
}
