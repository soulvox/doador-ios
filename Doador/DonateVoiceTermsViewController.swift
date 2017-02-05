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
        return UIBarButtonItem(
            title: Resources.Text.Buttons.cancel.label,
            style: .done,
            target: self,
            action: #selector(dismissDonateVoiceTermsViewController)
        )
    }()
    
    private lazy var continueButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: Resources.Text.Buttons.accept.label,
            style: .done,
            target: self,
            action: #selector(acceptTerms)
        )
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
        containerStackView.addArrangedSubview(termsLabel)
        containerStackView.pinToEdges(ofViewController: self)
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = continueButton
    }
    
    @objc private func dismissDonateVoiceTermsViewController() {
        delegate?.dismissDonateVoiceTermsViewController()
    }
    
    @objc private func acceptTerms() {
        delegate?.acceptTerms()
    }
}
