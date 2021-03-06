//
//  SegmentedControlCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class SegmentedControlCell: UITableViewCell, DisplaysExtraTextField, UITextFieldDelegate {
    
    var selectedIndex: Int {
        return segmentedControl.selectedSegmentIndex
    }
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    var items: [String] = [] {
        didSet {
            for (i, item) in items.enumerated() {
                segmentedControl.insertSegment(withTitle: item, at: i, animated: false)
            }
            
            segmentedControl.selectedSegmentIndex = 0
        }
    }
    
    var heightDidChange: ((Bool) -> Void)?
    
    var placeholder: String = "" {
        didSet {
            textField.placeholder = placeholder
        }
    }
    
    var keyboardType: UIKeyboardType = .default {
        didSet {
            textField.keyboardType = keyboardType
        }
    }
    
    var autocapitalizationType: UITextAutocapitalizationType = .sentences {
        didSet {
            textField.autocapitalizationType = autocapitalizationType
        }
    }
    
    var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            textField.autocorrectionType = autocorrectionType
        }
    }
    
    var textValue: String? {
        get {
            guard let text = textField.text else { return nil }
            
            let trimmedText = text.trimmingCharacters(in: .whitespacesAndNewlines)
            
            if trimmedText.characters.count == 0 {
                return nil
            }
            
            return trimmedText
        }
        
        set {
            textField.text = newValue
        }
    }
    
    let displaysExtraTextFieldOnLastItemSelection: Bool
    
    private var isLastItemSelected: Bool {
        return selectedIndex == items.count - 1
    }
    
    private let innerStackView: UIStackView = {
        return UIStackView.horizontalContainer
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.tintColor = UIColor.white
        return segmentedControl
    }()
    
    private lazy var textField: UITextField = {
        let textField = UITextField.plain
        textField.delegate = self
        return textField
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(displaysExtraTextFieldOnLastItemSelection: Bool = false, axis: UILayoutConstraintAxis = .horizontal, traitCollection: UITraitCollection) {
        self.displaysExtraTextFieldOnLastItemSelection = displaysExtraTextFieldOnLastItemSelection
        super.init(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        
        innerStackView.axis = axis
        
        setConstraints(usingTraitCollection: traitCollection)
        setAppearance()
        setActions()
    }
    
    private func setConstraints(usingTraitCollection traitCollection: UITraitCollection) {
        innerStackView.addArrangedSubview(label)
        innerStackView.addArrangedSubview(segmentedControl)
        
        contentView.addSubview(innerStackView)
        contentView.addSubview(textField)
        
        innerStackView.translatesAutoresizingMaskIntoConstraints = false
        innerStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        innerStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        
        if displaysExtraTextFieldOnLastItemSelection {
            innerStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16).isActive = true
        } else {
            innerStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor).isActive = true
        }
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.topAnchor.constraint(equalTo: innerStackView.bottomAnchor, constant: 16).isActive = true
        textField.leadingAnchor.constraint(equalTo: innerStackView.leadingAnchor).isActive = true
        textField.trailingAnchor.constraint(equalTo: innerStackView.trailingAnchor).isActive = true
        
        textField.isHidden = true
        
        let segmentedControlWidth: CGFloat = {
            switch traitCollection.horizontalSizeClass {
            case .regular:
                return bounds.size.width * 1.3
                
            case .compact, .unspecified:
                return (bounds.size.width / 5) * 3
            }
        }()
        
        segmentedControl.widthAnchor.constraint(equalToConstant: segmentedControlWidth).isActive = true
    }
    
    private func setAppearance() {
        backgroundColor = Resources.Colors.tint.color
    }
    
    private func setActions() {
        segmentedControl.addTarget(self, action: #selector(SegmentedControlCell.selectionChanged), for: .valueChanged)
    }
    
    @objc private func selectionChanged() {
        displayExtraTextFieldIfNeeded()
    }
    
    private func displayExtraTextFieldIfNeeded() {
        
        if displaysExtraTextFieldOnLastItemSelection && isLastItemSelected {
            textField.isHidden = false
            textField.becomeFirstResponder()
            
        } else {
            textField.isHidden = true
            textField.text = ""
            textField.resignFirstResponder()
        }
        
        heightDidChange?(!textField.isHidden)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
