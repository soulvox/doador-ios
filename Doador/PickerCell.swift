//
//  PickerCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol PickerCellDelegate: class {
    func pickerSelectedItemDidChange(for identifier: String, selectedItemIndex: Int)
}

final class PickerCell: UITableViewCell, UIPickerViewDataSource, UIPickerViewDelegate {
    
    weak var delegate: PickerCellDelegate?
    
    var labelText: String = "" {
        didSet {
            label.text = labelText
        }
    }
    
    private (set) var selectedIndex: Int = 0
    
    private let items: [String]
    
    private let stackView: UIStackView = {
        return UIStackView.verticalContainer
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let picker: UIPickerView = {
        let picker = UIPickerView()
        picker.tintColor = UIColor.white
        return picker
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(items: [String]) {
        self.items = [""] + items
        
        super.init(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        
        setConstraints()
        setAppearance()
        
        picker.dataSource = self
        picker.delegate = self
    }
    
    private func setConstraints() {
        stackView.spacing = 0
        stackView.distribution = .fill
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(picker)
        stackView.pinToEdges(ofView: self)
    }
    
    private func setAppearance() {
        backgroundColor = Resources.Colors.tint.color
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: items[row], attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedIndex = row - 1 // Subtract one due to the empty row inserted in the beginning
    }
}
