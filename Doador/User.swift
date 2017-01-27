//
//  User.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

struct User {
    
    enum Gender {
        case male, female
    }
    
    let firstName: String
    let lastName: String
    let email: String
    let phoneNumber: String
    let gender: Gender
}
