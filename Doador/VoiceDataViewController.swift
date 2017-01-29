//
//  VoiceDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol VoiceDataViewControllerDelegate: class {
    func submit(voiceData: VoiceData)
}

final class VoiceDataViewController: UIViewController, BackgroundColorable {
    
    weak var delegate: VoiceDataViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let voiceTypeSegmentedControl: UISegmentedControl = {
        let items = [
            VoiceData.VoiceType.low.label,
            VoiceData.VoiceType.high.label,
            VoiceData.VoiceType.other.label
        ]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.tintColor = UIColor.white
        return segmentedControl
    }()
    
    private let accentTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Sotaque de"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapable
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .default
        return textField
    }()
    
    private lazy var continueButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(submit))
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setBackgroundTintColor()
        setBackButtonTitle()
    }
    
    private func setupSubviews() {
        containerStackView.addArrangedSubview(voiceTypeSegmentedControl)
        containerStackView.addArrangedSubview(accentTextField)
        containerStackView.pinToTopEdges(ofViewController: self)
        
        navigationItem.rightBarButtonItem = continueButton
    }
    
    @objc private func submit() {
        guard let voiceType = VoiceData.VoiceType(rawValue: voiceTypeSegmentedControl.selectedSegmentIndex),
            let accent = accentTextField.text else { return }
        
        let data = VoiceData(voiceType: voiceType, accent: accent)
        
        delegate?.submit(voiceData: data)
    }
}
