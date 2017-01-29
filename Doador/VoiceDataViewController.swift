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

final class VoiceDataViewController: UITableViewController, BackgroundColorable, SegmentedControlCellDelegate, PickerCellDelegate {
    
    enum Sections: Int {
        
        enum VoiceDataRows: Int {
            case voiceType, accent, personalityType
            
            static var numberOfRows = 3
            
            var label: String {
                switch self {
                case .voiceType:
                    return "Tipo de voz"
                    
                case .accent:
                    return "Sotaque"
                    
                case .personalityType:
                    return "Personalidade"
                }
            }
            
            var placeholder: String {
                switch self {
                case .voiceType:
                    return ""
                    
                case .accent:
                    return "Paulista, Carioca, Mineiro, Gaúcho, etc"
                    
                case .personalityType:
                    return "Descreva sua personalidade (extrovertido, tímido, etc)"
                }
            }
            
            init?(identifier: String) {
                switch identifier {
                case VoiceDataRows.voiceType.label:
                    self = .voiceType
                    
                case VoiceDataRows.accent.label:
                    self = .accent
                    
                case VoiceDataRows.personalityType.label:
                    self = .personalityType
                    
                default:
                    return nil
                }
            }
        }
        
        case voiceData
        
        static var numberOfSections = 1
        
        var label: String {
            switch self {
            case .voiceData:
                return "Voz"
            }
        }
    }
    
    weak var delegate: VoiceDataViewControllerDelegate?
    
    private lazy var continueButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "Continuar", style: .done, target: self, action: #selector(submit))
        return button
    }()
    
    private var voiceType: VoiceData.VoiceType = .low
    private var accent: VoiceData.AccentType?
    private var personalityType: VoiceData.PersonalityType?
    
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
                let cell = SegmentedControlCell(identifier: Sections.VoiceDataRows.voiceType.label)
                cell.labelText = Sections.VoiceDataRows.voiceType.label
                cell.items = [VoiceData.VoiceType.low.label, VoiceData.VoiceType.high.label, VoiceData.VoiceType.other.label]
                cell.delegate = self
                return cell
                
            case .accent:
                let items = [""] + VoiceData.AccentType.items
                let cell = PickerCell(identifier: Sections.VoiceDataRows.accent.label, items: items)
                cell.labelText = Sections.VoiceDataRows.accent.label
                cell.delegate = self
                return cell
                
            case .personalityType:
                let items = [""] + VoiceData.PersonalityType.items
                let cell = PickerCell(identifier: Sections.VoiceDataRows.personalityType.label, items: items)
                cell.labelText = Sections.VoiceDataRows.personalityType.label
                cell.delegate = self
                return cell
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Sections(rawValue: section) else { return "" }
        return section.label
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.font = UIFont.preferredFont(forTextStyle: .caption1)
        header.textLabel?.textColor = UIColor.white
    }
    
    func segmentedControlSelectedItemDidChange(for identifier: String, selectedItemIndex: Int) {
        if let row = Sections.VoiceDataRows(identifier: identifier) {
            switch row {
            case .voiceType:
                guard let selectedVoiceType = VoiceData.VoiceType(rawValue: selectedItemIndex) else { return }
                voiceType = selectedVoiceType
                
            case .accent, .personalityType:
                break
            }
        }
    }
    
    func pickerSelectedItemDidChange(for identifier: String, selectedItemIndex: Int) {
        if let row = Sections.VoiceDataRows(identifier: identifier) {
            switch row {
            case .voiceType:
                break
                
            case .accent:
                guard selectedItemIndex != 0 else {
                    accent = nil
                    return
                }
                
                let selectedItem = VoiceData.AccentType.items[selectedItemIndex - 1]
                
                guard let selectedAccent = VoiceData.AccentType(label: selectedItem) else {
                    accent = nil
                    return
                }
                
                accent = selectedAccent
                
            case .personalityType:
                guard selectedItemIndex != 0 else {
                    personalityType = nil
                    return
                }
                
                let selectedItem = VoiceData.PersonalityType.items[selectedItemIndex - 1]
                
                guard let selectedPersonalityType = VoiceData.PersonalityType(label: selectedItem) else {
                    personalityType = nil
                    return
                }
                
                personalityType = selectedPersonalityType
            }
        }
    }
    
    @objc private func submit() {
        guard let accent = accent, let personalityType = personalityType else { return }
        
        let data = VoiceData(voiceType: voiceType, accent: accent, personalityType: personalityType)
        
        delegate?.submit(voiceData: data)
    }
}
