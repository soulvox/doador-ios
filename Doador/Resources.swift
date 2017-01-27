//
//  Resources.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

enum Resources {
    
    enum Images: String {
        case logo
        
        var image: UIImage? {
            return UIImage(named: self.rawValue)
        }
    }
}
