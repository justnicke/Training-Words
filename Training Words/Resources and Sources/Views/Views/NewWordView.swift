//
//  NewWordView.swift
//  Training Words
//
//  Created by Nikita Sukachev on 25.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class NewWordView: UIView {
    
    // MARK: - Public Properties
    
    var discriptionLabel: UILabel!
    var topView: UIView!
    var engishWordTextField: CustomTextField!
    var russianWordTextField: CustomTextField!
    var bottomView: UIView!
    var cancelButton: UIButton!
    var separateView: UIView!
    var okButton: UIButton!
    
    // MARK: - Constructors

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        setupLabel()
        setupTopView()
        setupBottomView()
        
        self.layer.cornerRadius = 10
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupLabel() {
        discriptionLabel = UILabel()
        discriptionLabel.textAlignment = .center
        discriptionLabel.text = "New word to learn"
        discriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        discriptionLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        discriptionLabel.font = UIFont(name: "AvenirNext-medium", size: 20)
        discriptionLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(discriptionLabel)
        
//        discriptionLabel.backgroundColor = #colorLiteral(red: 0.8549019694, green: 0.250980407, blue: 0.4784313738, alpha: 1)
        
        discriptionLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        discriptionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        discriptionLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        discriptionLabel.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15).isActive = true
    }
    
    func setupTopView() {
        topView = UIView()
        topView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(topView)
        
//        topView.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        
        topView.topAnchor.constraint(equalTo: discriptionLabel.bottomAnchor).isActive = true
        topView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.55).isActive = true
    
        setupTextFilds()
    }
    
    func setupBottomView() {
        bottomView = UIView()
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(bottomView)
        
//        bottomView.backgroundColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        bottomView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.30).isActive = true
        
        setupButton()
    }
    
    func setupTextFilds() {
        engishWordTextField = CustomTextField()
        engishWordTextField.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(engishWordTextField)
        
        engishWordTextField.placeholder = "Enter translate"
        engishWordTextField.font = UIFont(name: "AvenirNext-medium", size: 25)
        engishWordTextField.clipsToBounds = true
        engishWordTextField.borderStyle = .none
        engishWordTextField.returnKeyType = .send
        engishWordTextField.enablesReturnKeyAutomatically = true
        engishWordTextField.autocapitalizationType = .none
        engishWordTextField.autocorrectionType = .no
        engishWordTextField.spellCheckingType = .no
        engishWordTextField.borderInactiveBottomColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        engishWordTextField.borderActiveBottomColor = #colorLiteral(red: 0.463878572, green: 0.4404314756, blue: 0.9081067443, alpha: 0.9995117188)
        engishWordTextField.placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        engishWordTextField.placeholderFontScale = 0.80
        engishWordTextField.textColor = .white
        engishWordTextField.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
        engishWordTextField.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        engishWordTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        engishWordTextField.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4).isActive = true
        
        russianWordTextField = CustomTextField()
        russianWordTextField.translatesAutoresizingMaskIntoConstraints = false
        topView.addSubview(russianWordTextField)
        
        russianWordTextField.placeholder = "Enter translate"
        russianWordTextField.font = UIFont(name: "AvenirNext-medium", size: 25)
        russianWordTextField.clipsToBounds = true
        russianWordTextField.borderStyle = .none
        russianWordTextField.returnKeyType = .send
        russianWordTextField.enablesReturnKeyAutomatically = true
        russianWordTextField.autocapitalizationType = .none
        russianWordTextField.autocorrectionType = .no
        russianWordTextField.spellCheckingType = .no
        russianWordTextField.borderInactiveBottomColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        russianWordTextField.borderActiveBottomColor = #colorLiteral(red: 0.463878572, green: 0.4404314756, blue: 0.9081067443, alpha: 0.9995117188)
        russianWordTextField.placeholderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        russianWordTextField.placeholderFontScale = 0.80
        russianWordTextField.textColor = .white
        russianWordTextField.topAnchor.constraint(equalTo: engishWordTextField.bottomAnchor).isActive = true
        russianWordTextField.leadingAnchor.constraint(equalTo: topView.leadingAnchor, constant: 20).isActive = true
        russianWordTextField.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -20).isActive = true
        russianWordTextField.heightAnchor.constraint(equalTo: topView.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func setupButton() {
        
        cancelButton = UIButton(type: .system)
//        cancelButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.tintColor = .red
        cancelButton.titleLabel?.font = UIFont(name: "AvenirNext-medium", size: 20)
        
        okButton = UIButton(type: .system)
//        okButton.backgroundColor = #colorLiteral(red: 0.3647058904, green: 0.06666667014, blue: 0.9686274529, alpha: 1)
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
}
