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
        return UIImageView(image: Resources.Images.logo.image)
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Text.soulvoxIntro.rawValue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor.white
        return label
    }()
    
    private let buttonsStackView: UIStackView = {
        let stackView = UIStackView.verticalContainer
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let donateVoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Seja um doador", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.borderColor = Resources.Colors.white.color.cgColor
        button.layer.masksToBounds = false
        button.layer.borderWidth = 1.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 12
        button.layer.shadowOpacity = 0.8
        button.backgroundColor = Resources.Colors.white.color
        button.addTarget(self, action: #selector(donateVoice), for: .touchUpInside)
        return button
    }()
    
    private let findDonatorButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Encontre um doador", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.layer.borderColor = Resources.Colors.white.color.cgColor
        button.layer.masksToBounds = false
        button.layer.borderWidth = 1.0
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 5, height: 5)
        button.layer.shadowRadius = 12
        button.layer.shadowOpacity = 0.8
        button.backgroundColor = Resources.Colors.white.color
        button.addTarget(self, action: #selector(findDonator), for: .touchUpInside)
        return button
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setupAppearance()
    }
    
    private func setupSubviews() {
        containerStackView.addArrangedSubview(logoImageView)
        containerStackView.addArrangedSubview(descriptionLabel)
        buttonsStackView.addArrangedSubview(donateVoiceButton)
        buttonsStackView.addArrangedSubview(findDonatorButton)
        containerStackView.addArrangedSubview(buttonsStackView)
        
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.tint.color
    }
    
    @objc private func donateVoice() {
        delegate?.donateVoice()
    }
    
    @objc private func findDonator() {
        delegate?.findDonator()
    }
}
