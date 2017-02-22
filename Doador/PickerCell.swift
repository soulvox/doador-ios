//
//  PickerCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol PickerCellDelegate: class {
    func pickerSelectedItemDidChange(for identifier: String, selectedItemIndex: Int)
}

final class PickerCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate, DisplaysExtraTextField, UITextFieldDelegate {
    
    weak var delegate: PickerCellDelegate?
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var displaysExtraTextFieldOnLastItemSelection: Bool = false
    var heightDidChange: ((Bool) -> Void)?
    
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            textField.autocapitalizationType = autocapitalizationType
        }
    }
    
    var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            textField.autocorrectionType = autocorrectionType
        }
    }
    
    var textValue: String? {
        get {
            guard let text = textField.text else { return nil }
            
            let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedText.characters.count == 0 {
                return nil
            }
            
            return trimmedText
        }
        
        set {
            textField.text = newValue
        }
    }
    
    private (set) var selectedIndex: Int = 0
    
    private let items: [String]
    
    private let stackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.tintColor = UIColor.white
        return picker
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField.plain
        textField.delegate = self
        return textField
    }()
    
    private var isLastItemSelected: Bool {
        // Substracting 2 items due to the empty item inserted at the beginning
        return selectedIndex == items.count - 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(items: [String]) {
        self.items = [""] + items
        
        super.init(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        
        setConstraints()
        setAppearance()
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    private func setConstraints() {
        stackView.spacing = 0
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(picker)
        stackView.addArrangedSubview(textField)
        stackView.pinToEdges(ofView: self)
        
        textField.isHidden = true
    }
    
    private func setAppearance() {
        backgroundColor = Resources.Colors.tint.color
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: items[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row - 1 // Subtract one due to the empty row inserted at the beginning
        displayExtraTextFieldIfNeeded()
    }
    
    private func displayExtraTextFieldIfNeeded() {
        if displaysExtraTextFieldOnLastItemSelection && isLastItemSelected {
            textField.isHidden = false
            textField.becomeFirstResponder()
            
        } else {
            textField.isHidden = true
            textField.text = ""
            textField.resignFirstResponder()
        }
        
        heightDidChange?(!textField.isHidden)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
