//
//  DisplaysExtraTextField.swift
//  Doador
//
//  Created by Rafael Alencar on 20/02/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

protocol DisplaysExtraTextField {
    var displaysExtraTextFieldOnLastItemSelection: Bool { get }
    var heightDidChange: ((Bool) -> Void)? { get set }
}
