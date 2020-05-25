//
//  AlertView.swift
//  Training Words
//
//  Created by Nikita Sukachev on 25.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

protocol ButtonDelegate: class {
    func cancelButtonTapped(sender: UIButton)
    func okButtonTapped(sender: UIButton)
}

final class AlertView: UIView {
    
    // MARK: - Public Properties
    
    let engishWordTextField = CustomTextField()
    let russianWordTextField = CustomTextField()
    weak var delegate: ButtonDelegate?
    
    // MARK: - Private Properties
    
    private var discriptionLabel: UILabel!
    private var topView: UIView!
    private var bottomView: UIView!
    private var cancelButton: UIButton!
    private var separateView: UIView!
    private var okButton: UIButton!
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        setupLabel()
        setupTopView()
        setupBottomView()
        
        self.layer.cornerRadius = 15
        
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        okButton.addTarget(self, action: #selector(okButtonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupLabel() {
        discriptionLabel = UILabel()
        discriptionLabel.textAlignment = .center
        discriptionLabel.text = "New word to learn"
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        discriptionLabel.font = UIFont(name: "AvenirNext-medium", size: 25)
        discriptionLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(discriptionLabel)
        
        discriptionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        discriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        discriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        discriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    private func setupTopView() {
        topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topView)
        
        topView.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
        
        setupTextField(customTextField: engishWordTextField, placeholder: "Enter English word", topConstraint: topView.topAnchor)
        setupTextField(customTextField: russianWordTextField, placeholder: "Enter Russian word", topConstraint: engishWordTextField.bottomAnchor)
    }
    
    private func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30).isActive = true
        
        setupButton()
    }
    
    private func setupTextField(customTextField: CustomTextField, placeholder: String, topConstraint: NSLayoutYAxisAnchor) {
        customTextField.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(customTextField)
        
        customTextField.placeholder = placeholder
        customTextField.font = UIFont(name: "AvenirNext-medium", size: 20)
        customTextField.clipsToBounds = true
        customTextField.borderStyle = .none
        customTextField.returnKeyType = .send
        customTextField.enablesReturnKeyAutomatically = true
        customTextField.autocapitalizationType = .none
        customTextField.autocorrectionType = .no
        customTextField.spellCheckingType = .no
        customTextField.borderInactiveBottomColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        customTextField.borderActiveBottomColor = #colorLiteral(red: 0.463878572, green: 0.4404314756, blue: 0.9081067443, alpha: 0.9995117188)
        customTextField.placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        customTextField.placeholderFontScale = 0.80
        customTextField.textColor = .white
        
        customTextField.topAnchor.constraint(equalTo: topConstraint).isActive = true
        customTextField.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        customTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        customTextField.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func setupButton() {
        cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .red
        cancelButton.titleLabel?.font = UIFont(name: "AvenirNext-medium", size: 20)
        
        okButton = UIButton(type: .system)
        okButton.setTitle("OK", for: .normal)
        okButton.tintColor = .white
        okButton.titleLabel?.font = UIFont(name: "AvenirNext-medium", size: 20)
        
        separateView = UIView()
        separateView.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        
        [cancelButton, okButton, separateView].forEach {
            $0?.translatesAutoresizingMaskIntoConstraints = false
            bottomView.addSubview($0!) }
        
        separateView.widthAnchor.constraint(equalToConstant: 2).isActive = true
        separateView.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5).isActive = true
        separateView.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor).isActive = true
        separateView.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor).isActive = true
        
        cancelButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        cancelButton.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 5).isActive = true
        cancelButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        cancelButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.45).isActive = true
        
        okButton.topAnchor.constraint(equalTo: bottomView.topAnchor, constant: 0).isActive = true
        okButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -5).isActive = true
        okButton.bottomAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 0).isActive = true
        okButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.45).isActive = true
    }
    
    @objc private func cancelButtonTapped(_ sender: UIButton) {
        delegate?.cancelButtonTapped(sender: sender)
    }
    
    @objc private func okButtonTapped(_ sender: UIButton) {
        delegate?.okButtonTapped(sender: sender)
    }
}
