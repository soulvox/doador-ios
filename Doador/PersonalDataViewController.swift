//
//  PersonalDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol PersonalDataViewControllerDelegate: class {
    func dismissPersonalDataViewController()
    func submit(personalData: PersonalData)
}

final class PersonalDataViewController: UITableViewController, TextFieldCellDelegate {
    
    enum Sections: Int {
        
        enum PersonalDataRows: Int {
            case name, age, gender, weight, height
            static var numberOfRows = 5
        }
        
        enum ContactDataRows: Int {
            case email, phone
            static var numberOfRows = 2
        }
        
        case personalData
        case contactData
        
        static var numberOfSections = 2
    }
    
    weak var delegate: PersonalDataViewControllerDelegate?
    
    private weak var nameCell: TextFieldCell?
    private weak var ageCell: NumberTextFieldCell?
    private weak var genderCell: SegmentedControlCell?
    private weak var weightCell: DecimalTextFieldCell?
    private weak var heightCell: DecimalTextFieldCell?
    private weak var emailCell: EmailTextFieldCell?
    private weak var phoneCell: PhoneTextFieldCell?
    
    private lazy var continueButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: Resources.Text.Buttons.continue.label,
            style: .done,
            target: self,
            action: #selector(submit)
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
                let cell = TextFieldCell(traitCollection: traitCollection)
                cell.labelText = Resources.Text.Cells.PersonalDataForm.name.label
                cell.placeholder = Resources.Text.Cells.PersonalDataForm.name.placeholder
                cell.keyboardType = .default
                cell.autocapitalizationType = .words
                cell.autocorrectionType = .no
                cell.delegate = self
                nameCell = cell
                return cell
                
            case .age:
                let cell = NumberTextFieldCell(traitCollection: traitCollection)
                cell.labelText = Resources.Text.Cells.PersonalDataForm.age.label
                cell.placeholder = Resources.Text.Cells.PersonalDataForm.age.placeholder
                cell.delegate = self
                ageCell = cell
                return cell
                
            case .gender:
                let cell = SegmentedControlCell(traitCollection: traitCollection)
                cell.labelText = Resources.Text.Cells.PersonalDataForm.gender.label
                cell.items = [PersonalData.Gender.male.label, PersonalData.Gender.female.label]
                genderCell = cell
                return cell
                
            case .weight:
                let cell = DecimalTextFieldCell(traitCollection: traitCollection)
                cell.labelText = Resources.Text.Cells.PersonalDataForm.weight.label
                cell.placeholder = Resources.Text.Cells.PersonalDataForm.weight.placeholder
                cell.delegate = self
                weightCell = cell
                return cell
                
            case .height:
                let cell = DecimalTextFieldCell(traitCollection: traitCollection)
                cell.labelText = Resources.Text.Cells.PersonalDataForm.height.label
                cell.placeholder = Resources.Text.Cells.PersonalDataForm.height.placeholder
                cell.delegate = self
                heightCell = cell
                return cell
            }

        case .contactData:
            guard let row = Sections.ContactDataRows(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .email:
                let validator = EmailValidator()
                let cell = EmailTextFieldCell(validator: validator, traitCollection: traitCollection)
                cell.delegate = self
                emailCell = cell
                return cell
                
            case .phone:
                let cell = PhoneTextFieldCell(traitCollection: traitCollection)
                cell.delegate = self
                phoneCell = cell
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Resources.Text.Sections.PersonalDataForm(rawValue: section) else { return "" }
        return section.label
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        header.textLabel?.textColor = UIColor.white
    }
    
    @objc private func dismissPersonalDataViewController() {
        delegate?.dismissPersonalDataViewController()
    }
    
    @objc private func submit() {
        view.endEditing(true)
        
        guard let name = nameCell?.textValue,
            let age = ageCell?.intValue,
            let genderIndex = genderCell?.selectedIndex,
            let gender = PersonalData.Gender(rawValue: genderIndex),
            let weight = weightCell?.doubleValue,
            let height = heightCell?.doubleValue,
            let email = emailCell?.textValue,
            let phone = phoneCell?.textValue else { return }
        
        let personalData = PersonalData(
            name: name,
            age: age, 
            gender: gender, 
            weight: weight, 
            height: height, 
            email: email,
            phone: phone
        )
        
        delegate?.submit(personalData: personalData)
    }
    
    func textFieldShouldReturn() -> Bool {
        submit()
        return true
    }
}
