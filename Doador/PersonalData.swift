//
//  PersonalData.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

struct PersonalData {
    
    enum Gender: Int {
        case male, female
        
        var label: String {
            switch self {
            case .male:
                return "Masculino"
                
            case .female:
                return "Feminino"
            }
        }
    }
    
    let name: String
    let age: Int
    let gender: Gender
    let weight: Double
    let height: Double
    let personalityDescription: String
}
