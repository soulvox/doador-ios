//
//  PhoneTextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 31/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class PhoneTextFieldCell: TextFieldCell {
    
    override init() {
        super.init()
        
        labelText = Resources.Text.Cells.PersonalDataForm.phone.label
        placeholder = Resources.Text.Cells.PersonalDataForm.phone.placeholder
        keyboardType = .phonePad
        autocapitalizationType = .none
        autocorrectionType = .no
        textMask = "(##) #########"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

