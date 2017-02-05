//
//  AcknowledgmentViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol AcknowledgmentViewControllerDelegate: class {
    func startOver()
}

final class AcknowledgmentViewController: UIViewController {
    
    weak var delegate: AcknowledgmentViewControllerDelegate?
    
    private let containerStackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let acknowledgmentLabel: UILabel = {
        let label = UILabel.descriptiveLabel
        label.text = Resources.Text.acknowledgment.rawValue
        return label
    }()
    
    private let startOverButton: UIButton = {
        let button = UIButton.actionButton
        button.setTitle(Resources.Text.Buttons.startOver.label, for: .normal)
        button.addTarget(self, action: #selector(startOver), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setBackgroundTintColor()
        unsetBackButton()
    }
    
    private func setupSubviews() {
        containerStackView.addArrangedSubview(acknowledgmentLabel)
        containerStackView.addArrangedSubview(startOverButton)
        containerStackView.pinToEdges(ofViewController: self)
    }
    
    @objc private func startOver() {
        delegate?.startOver()
    }
}
