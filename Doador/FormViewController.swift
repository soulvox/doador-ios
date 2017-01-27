//
//  FormViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol FormViewControllerDelegate: class {
    func cancel()
    func submit(user: User)
}

final class FormViewController: UIViewController {
    
    weak var delegate: FormViewControllerDelegate?
    
    private let firstNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let lastNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Sobrenome"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "E-mail"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let phoneTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Telefone"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    private let genderSegmentedControl: UISegmentedControl = {
        let items = ["Masculino", "Feminino"]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private lazy var cancelButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(FormViewController.cancel))
        return button
    }()
    
    private lazy var continueButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(FormViewController.submit))
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }
    
    private func setupSubviews() {
        view.addSubview(firstNameTextField)
        view.addSubview(lastNameTextField)
        view.addSubview(emailTextField)
        view.addSubview(phoneTextField)
        view.addSubview(genderSegmentedControl)
        
        firstNameTextField.translatesAutoresizingMaskIntoConstraints = false
        lastNameTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        genderSegmentedControl.translatesAutoresizingMaskIntoConstraints = false
        
        firstNameTextField.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        firstNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        firstNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        lastNameTextField.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 20).isActive = true
        lastNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        lastNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        emailTextField.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 20).isActive = true
        emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        phoneTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        phoneTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        phoneTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        
        genderSegmentedControl.topAnchor.constraint(equalTo: phoneTextField.bottomAnchor, constant: 20).isActive = true
        genderSegmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        navigationItem.leftBarButtonItem = cancelButton
        navigationItem.rightBarButtonItem = continueButton
    }
    
    @objc private func cancel() {
        delegate?.cancel()
    }
    
    @objc private func submit() {
        guard let firstName = firstNameTextField.text,
            let lastName = lastNameTextField.text,
            let email = emailTextField.text,
            let phoneNumber = phoneTextField.text else {
                return
        }
        
        let gender = genderSegmentedControl.selectedSegmentIndex == 0 ? User.Gender.male : User.Gender.female
        
        let user = User(firstName: firstName,
                        lastName: lastName,
                        email: email, 
                        phoneNumber: phoneNumber,
                        gender: gender)
        
        delegate?.submit(user: user)
    }
}
