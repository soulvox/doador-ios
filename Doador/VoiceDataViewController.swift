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
        tableView.estimatedRowHeight = 80
        tableView.rowHeight = UITableViewAutomaticDimension
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
                let cell = SegmentedControlCell()
                cell.labelText = Resources.Text.Cells.VoiceDataForm.voiceType.label
                cell.items = [
                    VoiceData.VoiceType.low.label,
                    VoiceData.VoiceType.high.label,
                    VoiceData.VoiceType.other.label
                ]
                
                voiceTypeCell = cell
                return cell
                
            case .accent:
                let cell = PickerCell(items: VoiceData.AccentType.items)
                cell.labelText = Resources.Text.Cells.VoiceDataForm.accent.label
                accentCell = cell
                return cell
                
            case .personalityType:
                let cell = PickerCell(items: VoiceData.PersonalityType.items)
                cell.labelText = Resources.Text.Cells.VoiceDataForm.personalityType.label
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
    
    @objc private func submit() {
        guard let voiceTypeIndex = voiceTypeCell?.selectedIndex,
            let voiceType = VoiceData.VoiceType(rawValue: voiceTypeIndex),
            let accentIndex = accentCell?.selectedIndex,
            let accent = VoiceData.AccentType(rawValue: accentIndex),
            let personalityTypeIndex = personalityTypeCell?.selectedIndex,
            let personalityType = VoiceData.PersonalityType(rawValue: personalityTypeIndex) else { return }
        
        let data = VoiceData(voiceType: voiceType, accent: accent, personalityType: personalityType)
        
        delegate?.submit(voiceData: data)
    }
}
