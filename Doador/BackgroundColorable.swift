//
//  BackgroundColorable.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

public protocol BackgroundColorable {
    var view: UIView! { get set }
}

extension BackgroundColorable {
    func setBackgroundTintColor() {
        view?.backgroundColor = Resources.Colors.tint.color
    }
}
