//
//  UILabel.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

extension UILabel {
    static var descriptiveLabel: UILabel {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = Resources.Colors.white.color
        return label
    }
}

