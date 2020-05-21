//
//  BottomView.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class BottomView: UIView {
    
    // MARK: - Public Properties

    var notificationLabel: UILabel!
    var englishCustomTextField: CustomTextField!
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .clear
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        
        setupLabelAndTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    func setupLabelAndTextField() {
        notificationLabel = UILabel()
        notificationLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(notificationLabel)
        
        notificationLabel.text = "Correctly"
        notificationLabel.font = UIFont(name: "AvenirNext-medium", size: 20)
        notificationLabel.textAlignment = .center
        notificationLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        notificationLabel.alpha = 0
        notificationLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30).isActive = true
        notificationLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        notificationLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        englishCustomTextField = CustomTextField()
        englishCustomTextField.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(englishCustomTextField)
        
        englishCustomTextField.placeholder = "enter translate"
        englishCustomTextField.font = UIFont(name: "AvenirNext-medium", size: 25)
        englishCustomTextField.clipsToBounds = true
        englishCustomTextField.borderStyle = .none
        englishCustomTextField.returnKeyType = .send
        englishCustomTextField.enablesReturnKeyAutomatically = true
        englishCustomTextField.autocapitalizationType = .none
        englishCustomTextField.autocorrectionType = .no
        englishCustomTextField.spellCheckingType = .no
        englishCustomTextField.borderInactiveBottomColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        englishCustomTextField.borderActiveBottomColor = #colorLiteral(red: 0.463878572, green: 0.4404314756, blue: 0.9081067443, alpha: 0.9995117188)
        englishCustomTextField.placeholderColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        englishCustomTextField.placeholderFontScale = 0.80
        englishCustomTextField.topAnchor.constraint(equalTo: notificationLabel.bottomAnchor, constant: 30).isActive = true
        englishCustomTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        englishCustomTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        englishCustomTextField.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.3).isActive = true
    }
}

