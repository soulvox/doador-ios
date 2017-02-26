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
        let double = DecimalTextFieldCell.numberFormatter.number(from: text)?.doubleValue
        return double
    }
    
    static let numberFormatter = NumberFormatter()
    
    init(traitCollection: UITraitCollection) {
        super.init(traitCollection: traitCollection)
        
        keyboardType = .decimalPad
        autocapitalizationType = .none
        autocorrectionType = .no
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

