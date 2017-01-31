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
    func textFieldDidChange(for identifier: String, text: String)
}

final class TextFieldCell: UITableViewCell, UITextFieldDelegate {
    
    enum TextFieldType {
        case phoneNumber, regular
    }
    
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
    
    fileprivate let identifier: String
    
    private let type: TextFieldType
    
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
    
    init(identifier: String, type: TextFieldType = .regular) {
        self.identifier = identifier
        self.type = type
        
        super.init(style: .default, reuseIdentifier: String(describing: TextFieldCell.self))
        
        setConstraints()
        setAppearance()
        applyMasks()
        
        NotificationCenter.default.addObserver(
            forName: Notification.Name.UITextFieldTextDidChange,
            object: textField,
            queue: .main) { [weak self] (notification) in
                guard let this = self, let text = this.textField.text else { return }
                this.delegate?.textFieldDidChange(for: this.identifier, text: text)
        }
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
    
    private func applyMasks() {
        switch type {
        case .phoneNumber:
            textField.mask = "(##) #########"
            textField.delegate = self
            
        case .regular:
            break
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return self.textField.shouldChangeCharacters(in: range, replacementString: string)
    }
}
