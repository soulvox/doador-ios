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
    
    let voiceType: VoiceType
    let accent: String
}
