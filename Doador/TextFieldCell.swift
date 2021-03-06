//
//  TextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol TextFieldCellDelegate: class {
    func textFieldShouldReturn() -> Bool
}

class TextFieldCell: UITableViewCell, UITextFieldDelegate, Validating {
    
    weak var delegate: TextFieldCellDelegate?
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
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
    
    var isValid: Bool = true {
        didSet {
            let textColor = isValid == true ? Resources.Colors.tint.color : UIColor.red
            textField.textColor = textColor
        }
    }
    
    private let stackView: UIStackView = {
        return UIStackView.horizontalContainer
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.7
        label.setContentHuggingPriority(UILayoutPriorityDefaultHigh, for: .horizontal)
        return label
    }()
    
    private let textField: UITextField
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(textField: UITextField = UITextField.plain, traitCollection: UITraitCollection) {
        self.textField = textField
        
        super.init(style: .default, reuseIdentifier: String(describing: TextFieldCell.self))
        
        setConstraints(usingTraitCollection: traitCollection)
        setAppearance()
        
        textField.delegate = self
    }
    
    private func setConstraints(usingTraitCollection traitCollection: UITraitCollection) {
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.pinToEdges(ofView: self)
        
        let textFieldWidth: CGFloat = {
            switch traitCollection.horizontalSizeClass {
            case .regular:
                return bounds.size.width * 1.3
                
            case .compact, .unspecified:
                return (bounds.size.width / 5) * 3
            }
        }()
        
        textField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
    }
    
    private func setAppearance() {
        backgroundColor = Resources.Colors.tint.color
    }
    
    func validate() -> Bool {
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if isValid == false {
            isValid = validate()
        }
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        isValid = validate()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn() ?? true
    }
}
