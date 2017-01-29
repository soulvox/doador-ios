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
    func submit(personalData: PersonalData, contactData: ContactData)
}

final class PersonalDataViewController: UITableViewController, BackgroundColorable, TextFieldCellDelegate, SegmentedControlCellDelegate {
    
    enum Sections: Int {
        
        enum PersonalDataRows: Int {
            case name, age, gender, weight, height
            
            static var numberOfRows = 5
            
            var label: String {
                switch self {
                    case .name: return "Nome"
                    case .age: return "Idade"
                    case .gender: return "Sexo"
                    case .weight: return "Peso"
                    case .height: return "Altura"
                }
            }
            
            var placeholder: String {
                switch self {
                    case .name: return "Nome completo"
                    case .age: return "Idade"
                    case .gender: return "Sexo"
                    case .weight: return "Peso (kg)"
                    case .height: return "Altura (m)"
                }
            }
            
            init?(identifier: String) {
                switch identifier {
                case PersonalDataRows.name.label:
                    self = .name
                    
                case PersonalDataRows.age.label:
                    self = .age
                    
                case PersonalDataRows.gender.label:
                    self = .gender
                    
                case PersonalDataRows.weight.label:
                    self = .weight
                    
                case PersonalDataRows.height.label:
                    self = .height
                    
                default:
                    return nil
                }
            }
        }
        
        enum ContactDataRows: Int {
            case email, phone
            
            static var numberOfRows = 2
            
            var label: String {
                switch self {
                    case .email: return "E-mail"
                    case .phone: return "Telefone"
                }
            }
            
            var placeholder: String {
                switch self {
                    case .email: return "E-mail"
                    case .phone: return "Telefone"
                }
            }
            
            init?(identifier: String) {
                switch identifier {
                case ContactDataRows.email.label:
                    self = .email
                    
                case ContactDataRows.phone.label:
                    self = .phone
                    
                default:
                    return nil
                }
            }
        }
        
        case personalData
        case contactData
        
        static var numberOfSections = 2
        
        var label: String {
            switch self {
                case .personalData: return "Dados pessoais"
                case .contactData: return "Dados para contato"
            }
        }
    }
    
    weak var delegate: PersonalDataViewControllerDelegate?
    
    private var name: String?
    private var age: Int?
    private var gender: PersonalData.Gender = .male
    private var weight: Double?
    private var height: Double?
    private var email: String?
    private var phone: String?
    
    private let numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale.current
        return numberFormatter
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
        setBackButtonTitle()
    }
    
    private func setupSubviews() {
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.allowsSelection = false
        
        navigationItem.rightBarButtonItem = continueButton
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        
        switch section {
        case .personalData:
            return Sections.PersonalDataRows.numberOfRows
            
        case .contactData:
            return Sections.ContactDataRows.numberOfRows
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .personalData:
            guard let row = Sections.PersonalDataRows(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .name:
                let cell = TextFieldCell(identifier: Sections.PersonalDataRows.name.label)
                cell.labelText = Sections.PersonalDataRows.name.label
                cell.placeholder = Sections.PersonalDataRows.name.placeholder
                cell.keyboardType = .default
                cell.autocapitalizationType = .words
                cell.autocorrectionType = .no
                cell.delegate = self
                return cell
                
            case .age:
                let cell = TextFieldCell(identifier: Sections.PersonalDataRows.age.label)
                cell.labelText = Sections.PersonalDataRows.age.label
                cell.placeholder = Sections.PersonalDataRows.age.placeholder
                cell.keyboardType = .numberPad
                cell.autocorrectionType = .no
                cell.delegate = self
                return cell
                
            case .gender:
                let cell = SegmentedControlCell(identifier: Sections.PersonalDataRows.gender.label)
                cell.labelText = Sections.PersonalDataRows.gender.label
                cell.items = [PersonalData.Gender.male.label, PersonalData.Gender.female.label]
                cell.delegate = self
                return cell
                
            case .weight:
                let cell = TextFieldCell(identifier: Sections.PersonalDataRows.weight.label)
                cell.labelText = Sections.PersonalDataRows.weight.label
                cell.placeholder = Sections.PersonalDataRows.weight.placeholder
                cell.keyboardType = .decimalPad
                cell.autocorrectionType = .no
                cell.delegate = self
                return cell
                
            case .height:
                let cell = TextFieldCell(identifier: Sections.PersonalDataRows.height.label)
                cell.labelText = Sections.PersonalDataRows.height.label
                cell.placeholder = Sections.PersonalDataRows.height.placeholder
                cell.keyboardType = .decimalPad
                cell.autocorrectionType = .no
                cell.delegate = self
                return cell
            }

        case .contactData:
            guard let row = Sections.ContactDataRows(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .email:
                let cell = TextFieldCell(identifier: Sections.ContactDataRows.email.label)
                cell.labelText = Sections.ContactDataRows.email.label
                cell.placeholder = Sections.ContactDataRows.email.placeholder
                cell.keyboardType = .emailAddress
                cell.autocapitalizationType = .none
                cell.autocorrectionType = .no
                cell.delegate = self
                return cell
                
            case .phone:
                let cell = TextFieldCell(identifier: Sections.ContactDataRows.phone.label)
                cell.labelText = Sections.ContactDataRows.phone.label
                cell.placeholder = Sections.ContactDataRows.phone.placeholder
                cell.keyboardType = .phonePad
                cell.autocapitalizationType = .none
                cell.autocorrectionType = .no
                cell.delegate = self
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Sections(rawValue: section) else { return "" }
        return section.label
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        header.textLabel?.textColor = UIColor.white
    }
    
    func textFieldDidChange(for identifier: String, text: String) {
        if let row = Sections.PersonalDataRows(identifier: identifier) {
            switch row {
            case .name:
                name = text
                
            case .age:
                age = Int(text)
                
            case .weight:
                weight = numberFormatter.number(from: text) as Double?
                
            case .height:
                height = numberFormatter.number(from: text) as Double?
                
            default:
                break
            }
        
        } else if let row = Sections.ContactDataRows(identifier: identifier) {
            switch row {
            case .email:
                email = text
                
            case .phone:
                phone = text
            }
        }
    }
    
    func segmentedControlSelectedItemDidChange(for identifier: String, selectedItemIndex: Int) {
        if let row = Sections.PersonalDataRows(identifier: identifier) {
            switch row {
            case .gender:
                guard let selectedGender = PersonalData.Gender(rawValue: selectedItemIndex) else { return }
                gender = selectedGender
                
            default:
                break
            }
        }
    }
    
    @objc private func dismissPersonalDataViewController() {
        delegate?.dismissPersonalDataViewController()
    }
    
    @objc private func submit() {
        guard let name = name,
            let age = age,
            let weight = weight,
            let height = height,
            let email = email,
            let phone = phone else { return }
        
        let personalData = PersonalData(name: name, age: age, gender: gender, weight: weight, height: height)
        let contactData = ContactData(email: email, phoneNumber: phone)
        
        delegate?.submit(personalData: personalData, contactData: contactData)
    }
}
