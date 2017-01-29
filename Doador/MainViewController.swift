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

final class MainViewController: UIViewController, BackgroundColorable {
    
    weak var delegate: MainViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let logoImageView: UIImageView = {
        return UIImageView(image: Resources.Images.logo.image)
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel.descriptiveLabel
        label.text = Resources.Text.soulvoxIntro.rawValue
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView.verticalContainer
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let donateVoiceButton: UIButton = {
        let button = UIButton.actionButton
        button.setTitle("Seja um doador", for: .normal)
        button.addTarget(self, action: #selector(donateVoice), for: .touchUpInside)
        return button
    }()
    
    private let findDonatorButton: UIButton = {
        let button = UIButton.actionButton
        button.setTitle("Encontre um doador", for: .normal)
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
        containerStackView.pinToEdges(of: self)
    }
    
    @objc private func donateVoice() {
        delegate?.donateVoice()
    }
    
    @objc private func findDonator() {
        delegate?.findDonator()
    }
}
