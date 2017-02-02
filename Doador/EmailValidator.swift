//
//  EmailValidator.swift
//  Doador
//
//  Created by Rafael Alencar on 30/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import Foundation

protocol EmailValidating {
    func validate(_ email: String) -> Bool
}

final class EmailValidator: EmailValidating {
    
    func validate(_ email: String) -> Bool {
        
        let regex: NSRegularExpression
        
        do {
            regex = try NSRegularExpression(pattern: ".*@.*\\..*", options: [])
        }
        catch {
            print("Invalid regular expression for validating email.")
            return false
        }
        
        let text = email as NSString
        let matches = regex.matches(in: email, options: [], range: NSRange(location: 0, length: text.length))
        let results = matches.map { text.substring(with: $0.range) }
        
        return results.count > 0
    }
}
