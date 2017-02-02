//
//  DecimalTextFieldCell.swift
//  Doador
//
//  Created by Rafael Alencar on 01/02/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class DecimalTextFieldCell: TextFieldCell {
    
    var doubleValue: Double? {
        guard let text = textValue else { return nil }
        return Double(text)
    }
    
    override init() {
        super.init()
        
        keyboardType = .decimalPad
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

