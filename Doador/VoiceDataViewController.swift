//
//  VoiceDataViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 28/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol VoiceDataViewControllerDelegate: class {
    func submit(voiceData: VoiceData)
}

final class VoiceDataViewController: UITableViewController {
    
    enum Sections: Int {
        enum VoiceDataRows: Int {
            case voiceType, accent, personalityType
            static var numberOfRows = 3
        }
        
        case voiceData
        static var numberOfSections = 1
    }
    
    weak var delegate: VoiceDataViewControllerDelegate?
    
    private lazy var continueButton: UIBarButtonItem = {
        return UIBarButtonItem(
            title: Resources.Text.Buttons.continue.label,
            style: .done,
            target: self,
            action: #selector(submit)
        )
    }()
    
    private weak var voiceTypeCell: SegmentedControlCell?
    private weak var accentCell: PickerCell?
    private weak var personalityTypeCell: PickerCell?
    
    private var voiceTypeCellExpanded = false
    private var accentCellExpanded = false
    private var personalityTypeCellExpanded = false
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        setBackgroundTintColor()
        setBackButtonTitle()
    }
    
    private func setupSubviews() {
        tableView.allowsSelection = false
        navigationItem.rightBarButtonItem = continueButton
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return Sections.numberOfSections
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Sections(rawValue: section) else { return 0 }
        
        switch section {
        case .voiceData:
            return Sections.VoiceDataRows.numberOfRows
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Sections(rawValue: indexPath.section) else { return UITableViewCell() }
        
        switch section {
        case .voiceData:
            guard let row = Sections.VoiceDataRows(rawValue: indexPath.row) else { return UITableViewCell() }
            
            switch row {
            case .voiceType:
                let cell = SegmentedControlCell(displaysExtraTextFieldOnLastItemSelection: true)
                cell.labelText = Resources.Text.Cells.VoiceDataForm.voiceType.label
                cell.items = [
                    VoiceData.VoiceType.low.label,
                    VoiceData.VoiceType.high.label,
                    VoiceData.VoiceType.other(description: "").label
                ]
                
                cell.placeholder = Resources.Text.Cells.VoiceDataForm.voiceType.placeholder
                
                cell.heightDidChange = { [weak tableView] expanded in
                    self.voiceTypeCellExpanded = expanded
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
                
                voiceTypeCell = cell
                return cell
                
            case .accent:
                let cell = PickerCell(items: VoiceData.AccentType.items)
                cell.labelText = Resources.Text.Cells.VoiceDataForm.accent.label
                cell.displaysExtraTextFieldOnLastItemSelection = true
                cell.placeholder = Resources.Text.Cells.VoiceDataForm.accent.placeholder
                
                cell.heightDidChange = { [weak tableView] expanded in
                    self.accentCellExpanded = expanded
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
                
                accentCell = cell
                return cell
                
            case .personalityType:
                let cell = PickerCell(items: VoiceData.PersonalityType.items)
                cell.labelText = Resources.Text.Cells.VoiceDataForm.personalityType.label
                cell.displaysExtraTextFieldOnLastItemSelection = true
                cell.placeholder = Resources.Text.Cells.VoiceDataForm.personalityType.placeholder
                
                cell.heightDidChange = { [weak tableView] expanded in
                    self.personalityTypeCellExpanded = expanded
                    tableView?.beginUpdates()
                    tableView?.endUpdates()
                }
                
                personalityTypeCell = cell
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        header.textLabel?.textColor = UIColor.white
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Sections(rawValue: indexPath.section) else { return 80 }
        
        switch section {
        case .voiceData:
            guard let row = Sections.VoiceDataRows(rawValue: indexPath.row) else { return 80 }
            
            switch row {
            case .voiceType:
                return voiceTypeCellExpanded ? 120 : 80
                
            case .accent:
                return accentCellExpanded ? 220 : 180
                
            case .personalityType:
                return personalityTypeCellExpanded ? 220 : 180
            }
        }
    }
    
    @objc private func submit() {
        guard let voiceTypeIndex = voiceTypeCell?.selectedIndex,
            let accentIndex = accentCell?.selectedIndex,
            let personalityTypeIndex = personalityTypeCell?.selectedIndex else { return }
        
        let voiceTypeDescription = voiceTypeCell?.textValue ?? ""
        let accentDescription = accentCell?.textValue ?? ""
        let personalityDescription = personalityTypeCell?.textValue ?? ""
        
        guard let voiceType = VoiceData.VoiceType(index: voiceTypeIndex, extraDescription: voiceTypeDescription),
            let accent = VoiceData.AccentType(index: accentIndex, extraDescription: accentDescription),
            let personalityType = VoiceData.PersonalityType(index: personalityTypeIndex, extraDescription: personalityDescription) else { return }
        
        let data = VoiceData(voiceType: voiceType, accent: accent, personalityType: personalityType)
        
        delegate?.submit(voiceData: data)
    }
}
