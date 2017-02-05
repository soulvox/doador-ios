//
//  UITextField.swift
//  Doador
//
//  Created by Rafael Alencar on 05/02/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit
import PhoneNumberKit

extension UITextField {
    static var plain: UITextField {
        let textField = UITextField()
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.borderStyle = .roundedRect
        return textField
    }
    
    static var phoneNumber: UITextField {
        let textField = PhoneNumberTextField()
        textField.backgroundColor = Resources.Colors.white.color
        textField.textColor = Resources.Colors.tint.color
        textField.borderStyle = .roundedRect
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        return textField
    }
}
