//
//  VoiceDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol VoiceDataViewControllerDelegate: class {
    func dismissVoiceDataViewController()
    func submit(voiceData: VoiceData)
}

final class VoiceDataViewController: UIViewController {
    
    weak var delegate: VoiceDataViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
    }()
    
    private let voiceTypeSegmentedControl: UISegmentedControl = {
        let items = [
            VoiceData.VoiceType.low.label,
            VoiceData.VoiceType.high.label,
            VoiceData.VoiceType.other.label
        ]
        
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
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
    
    private lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Voltar", style: .done, target: self, action: #selector(dismissVoiceDataViewController))
        return button
    }()
    
    private lazy var continueButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(submit))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        view.backgroundColor = UIColor.white
    }
    
    private func setupSubviews() {
        containerStackView.addArrangedSubview(voiceTypeSegmentedControl)
        containerStackView.addArrangedSubview(accentTextField)
        
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = continueButton
    }
    
    @objc private func dismissVoiceDataViewController() {
        delegate?.dismissVoiceDataViewController()
    }
    
    @objc private func submit() {
        guard let voiceType = VoiceData.VoiceType(rawValue: voiceTypeSegmentedControl.selectedSegmentIndex),
            let accent = accentTextField.text else { return }
        
        let data = VoiceData(voiceType: voiceType, accent: accent)
        
        delegate?.submit(voiceData: data)
    }
}
