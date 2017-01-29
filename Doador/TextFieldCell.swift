//
//  TextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol TextFieldCellDelegate: class {
    func textFieldDidChange(for identifier: String, text: String)
}

final class TextFieldCell: UITableViewCell {
    
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
    
    private let identifier: String
    
    private let stackView: UIStackView = {
        return UIStackView.horizontalContainer
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.white
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.borderStyle = .roundedRect
//        textField.textColor = UIColor.white
        return textField
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(identifier: String) {
        self.identifier = identifier
        
        super.init(style: .default, reuseIdentifier: String(describing: TextFieldCell.self))
        
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        stackView.pinToEdges(ofView: self)
        
        let textFieldWidth = (bounds.size.width / 3) * 2
        textField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        
        backgroundColor = Resources.Colors.tint.color
        
        let center = NotificationCenter.default
        center.addObserver(
            forName: Notification.Name.UITextFieldTextDidChange,
            object: textField,
            queue: .main) { [weak self] (notification) in
                guard let this = self, let text = this.textField.text else { return }
                this.delegate?.textFieldDidChange(for: this.identifier, text: text)
        }
    }
}
