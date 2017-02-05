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
        case saoPauloCapital
        case saoPauloInterior
        case rioDeJaneiroCapital
        case rioDeJaneiroInterior
        case portoAlegre
        case beloHorizonte
        case other
        
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
                AccentType.other.label
            ]
        }
        
        init?(label: String) {
            switch label {
            case AccentType.saoPauloCapital.label:
                self = .saoPauloCapital
                
            case AccentType.saoPauloInterior.label:
                self = .saoPauloInterior
                
            case AccentType.rioDeJaneiroCapital.label:
                self = .rioDeJaneiroCapital
                
            case AccentType.rioDeJaneiroInterior.label:
                self = .rioDeJaneiroInterior
                
            case AccentType.portoAlegre.label:
                self = .portoAlegre
                
            case AccentType.beloHorizonte.label:
                self = .beloHorizonte
                
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
