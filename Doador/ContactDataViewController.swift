//
//  ContactDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol ContactDataViewControllerDelegate: class {
    func dismissContactDataViewController()
    func submit(contactData: ContactData)
}

final class ContactDataViewController: UIViewController {
    
    weak var delegate: ContactDataViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 20
        return stackView
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
    
    private lazy var dismissButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Voltar", style: .done, target: self, action: #selector(dismissContactDataViewController))
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
        containerStackView.addArrangedSubview(emailTextField)
        containerStackView.addArrangedSubview(phoneTextField)
        
        view.addSubview(containerStackView)
        
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerStackView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        containerStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
        containerStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16).isActive = true
        
        navigationItem.leftBarButtonItem = dismissButton
        navigationItem.rightBarButtonItem = continueButton
    }
    
    @objc private func dismissContactDataViewController() {
        delegate?.dismissContactDataViewController()
    }
    
    @objc private func submit() {
        guard let email = emailTextField.text,
            let phoneNumber = phoneTextField.text else { return }
        
        let data = ContactData(email: email, phoneNumber: phoneNumber)
        
        delegate?.submit(contactData: data)
    }
}
