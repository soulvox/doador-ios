//
//  MainViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func donateVoice()
    func findDonator()
}

final class MainViewController: UIViewController {
    
    weak var delegate: MainViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView(image: Resources.Images.logo.image)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel.descriptiveLabel
        label.text = Resources.Text.soulvoxIntro.rawValue
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView.verticalContainer
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let donateVoiceButton: UIButton = {
        let button = UIButton.actionButton
        button.setTitle(Resources.Text.Buttons.donateVoice.label, for: .normal)
        button.addTarget(self, action: #selector(donateVoice), for: .touchUpInside)
        return button
    }()
    
    private let findDonatorButton: UIButton = {
        let button = UIButton.actionButton
        button.setTitle(Resources.Text.Buttons.findDonator.label, for: .normal)
        button.addTarget(self, action: #selector(findDonator), for: .touchUpInside)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setBackgroundTintColor()
    }
    
    private func setupSubviews() {
        containerStackView.addArrangedSubview(logoImageView)
        containerStackView.addArrangedSubview(descriptionLabel)
        buttonsStackView.addArrangedSubview(donateVoiceButton)
        buttonsStackView.addArrangedSubview(findDonatorButton)
        containerStackView.addArrangedSubview(buttonsStackView)
        
        switch traitCollection.horizontalSizeClass {
        case .regular:
            buttonsStackView.leadingAnchor.constraint(equalTo: containerStackView.leadingAnchor, constant: 75).isActive = true
            buttonsStackView.trailingAnchor.constraint(equalTo: containerStackView.trailingAnchor, constant: -75).isActive = true
            
            let insets = UIEdgeInsets(top: 20, left: 36, bottom: -20, right: -36)
            containerStackView.pinToEdges(ofViewController: self, insets: insets)
        
        case .compact, .unspecified:
            containerStackView.pinToEdges(ofViewController: self)
        }
    }
    
    @objc private func donateVoice() {
        delegate?.donateVoice()
    }
    
    @objc private func findDonator() {
        delegate?.findDonator()
    }
}
