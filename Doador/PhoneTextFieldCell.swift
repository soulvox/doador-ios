//
//  PhoneTextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 31/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class PhoneTextFieldCell: TextFieldCell {
    
    init() {
        super.init(textField: UITextField.phoneNumber)
        
        labelText = Resources.Text.Cells.PersonalDataForm.phone.label
        placeholder = Resources.Text.Cells.PersonalDataForm.phone.placeholder
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

