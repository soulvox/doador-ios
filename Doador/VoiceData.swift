//
//  VoiceData.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

struct VoiceData {
    
    enum VoiceType: Int {
        case low, high, other
        
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
    }
    
    enum AccentType: Int {
        case saoPaulo, saoPauloInterior, rioDeJaneiro, rioDeJaneiroInterior, gaucho, mineiro, other
        
        var label: String {
            switch self {
            case .saoPaulo:
                return "São Paulo"
                
            case .saoPauloInterior:
                return "Interior de São Paulo"
                
            case .rioDeJaneiro:
                return "Rio de Janeiro"
                
            case .rioDeJaneiroInterior:
                return "Interior do Rio de Janeiro"
                
            case .gaucho:
                return "Gaúcho"
                
            case .mineiro:
                return "Mineiro"
                
            case .other:
                return "Outro"
            }
        }
        
        static var items: [String] {
            return [AccentType.saoPaulo.label, AccentType.saoPauloInterior.label, AccentType.rioDeJaneiro.label, AccentType.rioDeJaneiroInterior.label, AccentType.gaucho.label, AccentType.mineiro.label, AccentType.other.label]
        }
        
        init?(label: String) {
            switch label {
            case AccentType.saoPaulo.label:
                self = .saoPaulo
                
            case AccentType.saoPauloInterior.label:
                self = .saoPauloInterior
                
            case AccentType.rioDeJaneiro.label:
                self = .rioDeJaneiro
                
            case AccentType.rioDeJaneiroInterior.label:
                self = .rioDeJaneiroInterior
                
            case AccentType.gaucho.label:
                self = .gaucho
                
            case AccentType.mineiro.label:
                self = .mineiro
                
            case AccentType.other.label:
                self = .other
                
            default:
                return nil
            }
        }
    }
    
    enum PersonalityType: Int {
        case extrovert, shy, other
        
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
            return [PersonalityType.extrovert.label, PersonalityType.shy.label, PersonalityType.other.label]
        }
        
        init?(label: String) {
            switch label {
            case PersonalityType.extrovert.label:
                self = .extrovert
                
            case PersonalityType.shy.label:
                self = .shy
                
            case PersonalityType.other.label:
                self = .other
                
            default:
                return nil
            }
        }
    }
    
    let voiceType: VoiceType
    let accent: AccentType
    let personalityType: PersonalityType
}
