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
        return UILabel.descriptiveLabel
    }()
    
    private let startOverButton: UIButton = {
        let button = UIButton.actionButton
        button.setTitle(Resources.Text.Buttons.startOver.label, for: .normal)
        button.addTarget(self, action: #selector(startOver), for: .touchUpInside)
        return button
    }()
    
    init(acknowledgmentLabelText: String) {
        acknowledgmentLabel.text = acknowledgmentLabelText
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
