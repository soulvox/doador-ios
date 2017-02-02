//
//  EmailTextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 31/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class EmailTextFieldCell: TextFieldCell {
    
    let validator: EmailValidating

    init(validator: EmailValidating) {
        self.validator = validator
        
        super.init()
        
        labelText = Resources.Text.Cells.PersonalDataForm.email.label
        placeholder = Resources.Text.Cells.PersonalDataForm.email.placeholder
        keyboardType = .emailAddress
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func validate() -> Bool {
        if let email = textValue, validator.validate(email) == false {
            return false
        }
        
        return true
    }
}
