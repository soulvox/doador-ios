//
//  TextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import VMaskTextField

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
    
    var textMask: String? = nil {
        didSet {
            textField.mask = textMask
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
        return label
    }()
    
    private let textField: VMaskTextField = {
        let textField = VMaskTextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: String(describing: TextFieldCell.self))
        
        setConstraints()
        setAppearance()
        
        textField.delegate = self
    }
    
    private func setConstraints() {
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.pinToEdges(ofView: self)
        
        let textFieldWidth = (bounds.size.width / 3) * 2
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
        
        if textMask != nil {
            return self.textField.shouldChangeCharacters(in: range, replacementString: string)
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
