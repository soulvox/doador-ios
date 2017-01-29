//
//  DonateVoiceTermsViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol DonateVoiceTermsViewControllerDelegate: class {
    func dismissDonateVoiceTermsViewController()
    func acceptTerms()
}

final class DonateVoiceTermsViewController: UIViewController {
    
    weak var delegate: DonateVoiceTermsViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let termsLabel: UILabel = {
        let label = UILabel()
        label.text = Resources.Text.termsAndConditions.rawValue
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Resources.Colors.white.color
        return label
    }()
    
    private lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Cancelar", style: .done, target: self, action: #selector(dismissDonateVoiceTermsViewController))
        return button
    }()
    
    private lazy var continueButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Aceitar", style: .done, target: self, action: #selector(acceptTerms))
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
        containerStackView.addArrangedSubview(termsLabel)
        
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        containerStackView.bottomAnchor.constraint(equalTo: bottomLayoutGuide.topAnchor, constant: -10).isActive = true
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = continueButton
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.tint.color
    }
    
    @objc private func dismissDonateVoiceTermsViewController() {
        delegate?.dismissDonateVoiceTermsViewController()
    }
    
    @objc private func acceptTerms() {
        delegate?.acceptTerms()
    }
}
