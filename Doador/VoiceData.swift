//
//  VoiceData.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

struct VoiceData {
    
    enum VoiceType {
        case low
        case high
        case other(description: String)
        
        var label: String {
            switch self {
            case .low:
                return "Grave"
                
            case .high:
                return "Aguda"
                
            case .other:
                return "Outro"
            }
        }
        
        init?(index: Int, extraDescription: String) {
            switch (index, extraDescription) {
            case (0, _):
                self = .low
                
            case (1, _):
                self = .high
                
            case (2, let description):
                self = .other(description: description)
                
            case (_, _):
                return nil
            }
        }
    }
    
    enum AccentType {
        case saoPauloCapital
        case saoPauloInterior
        case rioDeJaneiroCapital
        case rioDeJaneiroInterior
        case portoAlegre
        case beloHorizonte
        case other(description: String)
        
        var label: String {
            switch self {
            case .saoPauloCapital:
                return "São Paulo - Capital"
                
            case .saoPauloInterior:
                return "São Paulo - Interior"
                
            case .rioDeJaneiroCapital:
                return "Rio de Janeiro - Capital"
                
            case .rioDeJaneiroInterior:
                return "Rio de Janeiro - Interior"
                
            case .portoAlegre:
                return "Porto Alegre"
                
            case .beloHorizonte:
                return "Belo Horizonte"
                
            case .other:
                return "Outro"
            }
        }
        
        static var items: [String] {
            return [
                AccentType.saoPauloCapital.label,
                AccentType.saoPauloInterior.label,
                AccentType.rioDeJaneiroCapital.label,
                AccentType.rioDeJaneiroInterior.label,
                AccentType.portoAlegre.label,
                AccentType.beloHorizonte.label,
                AccentType.other(description: "").label
            ]
        }
        
        
        init?(index: Int, extraDescription: String) {
            switch (index, extraDescription) {
            case (0, _):
                self = .saoPauloCapital
                
            case (1, _):
                self = .saoPauloInterior
                
            case (2, _):
                self = .rioDeJaneiroCapital
                
            case (3, _):
                self = .rioDeJaneiroInterior
                
            case (4, _):
                self = .portoAlegre
                
            case (5, _):
                self = .beloHorizonte
                
            case (6, let description):
                self = .other(description: description)
                
            case (_, _):
                return nil
            }
        }
    }
    
    enum PersonalityType {
        case extrovert
        case shy
        case other(description: String)
        
        var label: String {
            switch self {
            case .extrovert:
                return "Extrovertído"
                
            case .shy:
                return "Tímido"
                
            case .other:
                return "Outro"
            }
        }
        
        static var items: [String] {
            return [
                PersonalityType.extrovert.label,
                PersonalityType.shy.label,
                PersonalityType.other(description: "").label
            ]
        }
        
        init?(index: Int, extraDescription: String = "") {
            switch (index, extraDescription) {
            case (0, _):
                self = .extrovert
                
            case (1, _):
                self = .shy
                
            case (2, let description):
                self = .other(description: description)
                
            case (_, _):
                return nil
            }
        }
    }
    
    let voiceType: VoiceType
    let accent: AccentType
    let personalityType: PersonalityType
}
