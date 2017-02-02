//
//  Validating.swift
//  Doador
//
//  Created by Rafael Alencar on 01/02/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

protocol Validating {
    var isValid: Bool { get set }
    func validate() -> Bool
}
