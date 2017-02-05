//
//  NumberTextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 01/02/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class NumberTextFieldCell: TextFieldCell {
    
    var intValue: Int? {
        guard let text = textValue else { return nil }
        return Int(text)
    }
    
    init() {
        super.init()
        
        keyboardType = .numberPad
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
