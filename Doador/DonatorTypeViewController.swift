//
//  DonatorTypeViewController.swift
//  Doador
//
//  Created by Rafael Alencar on 26/01/17.
//  Copyright © 2017 Soulvox. All rights reserved.
//

import UIKit

protocol DonatorTypeViewControllerDelegate: class {
    func donateVoice()
}

final class DonatorTypeViewController: UIViewController {
    
    let logoImageView: UIImageView = {
        return UIImageView(image: Resources.Images.logo.image)
    }()
    
    let donateVoiceButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Eu quero doar minha voz", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        return button
    }()
    
    weak var delegate: DonatorTypeViewControllerDelegate?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(delegate: DonatorTypeViewControllerDelegate? = nil) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
        
        view.backgroundColor = UIColor.white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupSubviews() {
        view.addSubview(logoImageView)
        view.addSubview(donateVoiceButton)
        
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: 20).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        logoImageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        donateVoiceButton.translatesAutoresizingMaskIntoConstraints = false
        donateVoiceButton.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50).isActive = true
        donateVoiceButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        donateVoiceButton.addTarget(self, action: #selector(DonatorTypeViewController.donateVoice), for: .touchUpInside)
    }
    
    @objc private func donateVoice() {
        delegate?.donateVoice()
    }
}
