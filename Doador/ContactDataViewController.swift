//
//  ContactDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol ContactDataViewControllerDelegate: class {
    func submit(contactData: ContactData)
}

final class ContactDataViewController: UIViewController {
    
    weak var delegate: ContactDataViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Telefone"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .phonePad
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
        setupAppearance()
    }
    
    private func setupSubviews() {
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(phoneTextField)
        
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        navigationItem.rightBarButtonItem = continueButton
    }
    
    private func setupAppearance() {
        view.backgroundColor = Resources.Colors.tint.color
    }
    
    @objc private func submit() {
        guard let email = emailTextField.text,
            let phoneNumber = phoneTextField.text else { return }
        
        let data = ContactData(email: email, phoneNumber: phoneNumber)
        
        delegate?.submit(contactData: data)
    }
}
