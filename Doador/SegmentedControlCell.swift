//
//  SegmentedControlCell.swift
//  Doador
//
//  Created by Rafael Alencar on 29/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

final class SegmentedControlCell: UITableViewCell {
    
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
    
    private let stackView: UIStackView = {
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init() {
        super.init(style: .default, reuseIdentifier: String(describing: UITableViewCell.self))
        
        setConstraints()
        setAppearance()
    }
    
    private func setConstraints() {
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(segmentedControl)
        stackView.pinToEdges(ofView: self)
        
        let segmentedControlWidth = (bounds.size.width / 3) * 2
        segmentedControl.widthAnchor.constraint(equalToConstant: segmentedControlWidth).isActive = true
    }
    
    private func setAppearance() {
        backgroundColor = Resources.Colors.tint.color
    }
}
