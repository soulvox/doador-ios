//
//  PersonalDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import SAMTextView

protocol PersonalDataViewControllerDelegate: class {
    func dismissPersonalDataViewController()
    func submit(personalData: PersonalData)
}

final class PersonalDataViewController: UIViewController, BackgroundColorable {
    
    weak var delegate: PersonalDataViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Nome"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapable
        textField.autocapitalizationType = .words
        textField.autocorrectionType = .no
        return textField
    }()
    
    private let ageTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Idade"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        return textField
    }()
    
    private let genderSegmentedControl: UISegmentedControl = {
        let items = [PersonalData.Gender.male.label, PersonalData.Gender.female.label]
        let segmentedControl = UISegmentedControl(items: items)
        segmentedControl.selectedSegmentIndex = 0
        return segmentedControl
    }()
    
    private let weightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Peso"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let heightTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Altura"
        textField.borderStyle = .roundedRect
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let personalityDescriptionTextView: SAMTextView = {
        let textView = SAMTextView(frame: CGRect(x: 0, y: 0, width: 200, height: 400))
        textView.placeholder = "Descreva sua personalidade (extrovertida, tímida...)"
        textView.font = UIFont.preferredFont(forTextStyle: .body)
        textView.layer.borderWidth = 1
        textView.keyboardType = .asciiCapable
        textView.autocapitalizationType = .sentences
        textView.autocorrectionType = .default
        textView.isScrollEnabled = false
        return textView
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
    }
    
    private func setupSubviews() {
        let ageGenderStackView = horizontalStackView()
        let weightHeightStackView = horizontalStackView()
        
        ageGenderStackView.addArrangedSubview(ageTextField)
        ageGenderStackView.addArrangedSubview(genderSegmentedControl)
        
        weightHeightStackView.addArrangedSubview(weightTextField)
        weightHeightStackView.addArrangedSubview(heightTextField)
        
        containerStackView.addArrangedSubview(nameTextField)
        containerStackView.addArrangedSubview(ageGenderStackView)
        containerStackView.addArrangedSubview(weightHeightStackView)
        containerStackView.addArrangedSubview(personalityDescriptionTextView)
        containerStackView.pinToTopEdges(of: self)
        
        navigationItem.rightBarButtonItem = continueButton
    }
    
    private func horizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 30
        return stackView
    }
    
    @objc private func dismissPersonalDataViewController() {
        delegate?.dismissPersonalDataViewController()
    }
    
    @objc private func submit() {
        guard let name = nameTextField.text,
            let ageText = ageTextField.text,
            let age = Int(ageText),
            let gender = PersonalData.Gender(rawValue: genderSegmentedControl.selectedSegmentIndex),
            let weightText = weightTextField.text,
            let weight = Double(weightText),
            let heightText = heightTextField.text,
            let height = Double(heightText),
            let personalityDescription = personalityDescriptionTextView.text else {
                return
        }
        
        let data = PersonalData(name: name,
                                age: age,
                                gender: gender,
                                weight: weight,
                                height: height,
                                personalityDescription: personalityDescription)
        
        delegate?.submit(personalData: data)
    }
}
