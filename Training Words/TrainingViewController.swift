//
//  TrainingViewController.swift
//  Training Words
//
//  Created by Nikita Sukachev on 19.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class TrainingViewController: UIViewController {

    // MARK: - Public Properties
        
    // MARK: - Private Properties
    
    private var forRussianWordView:       UIView!
    private var russianWordLabel:         UILabel!
    private var forTextFieldOrNotifyView: UIView!
    private var notifyLabel:              UILabel!
    private var englishCustomTextField:   CustomTextField!
    private var addNewWordButton:         UIButton!
    private var nextWordButton:           UIButton!
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        setupRussianLabelAndView()
        setupTextFieldViewAndNotify()
        setupAddNewWordButton()
    }
        
    // MARK: - Private Methods

    private func setupRussianLabelAndView() {
        forRussianWordView = UIView()
        forRussianWordView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        forRussianWordView.translatesAutoresizingMaskIntoConstraints = false
        forRussianWordView.layer.cornerRadius = 10
        view.addSubview(forRussianWordView)
        
        forRussianWordView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        forRussianWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        forRussianWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        forRussianWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        russianWordLabel = UILabel()
        russianWordLabel.textAlignment = .center
        russianWordLabel.text = "русское словосочетание или слово"
        russianWordLabel.translatesAutoresizingMaskIntoConstraints = false
        forRussianWordView.addSubview(russianWordLabel)
        
        russianWordLabel.heightAnchor.constraint(equalTo: forRussianWordView.heightAnchor).isActive = true
        russianWordLabel.widthAnchor.constraint(equalTo: forRussianWordView.widthAnchor).isActive = true
        russianWordLabel.centerYAnchor.constraint(equalTo: forRussianWordView.centerYAnchor).isActive = true
        russianWordLabel.centerXAnchor.constraint(equalTo: forRussianWordView.centerXAnchor).isActive = true
    }
    
    private func setupTextFieldViewAndNotify() {
        forTextFieldOrNotifyView = UIView()
        forTextFieldOrNotifyView.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        forTextFieldOrNotifyView.translatesAutoresizingMaskIntoConstraints = false
        forTextFieldOrNotifyView.layer.cornerRadius = 10
        view.addSubview(forTextFieldOrNotifyView)
        
        forTextFieldOrNotifyView.topAnchor.constraint(equalTo: forRussianWordView.bottomAnchor, constant: 20).isActive = true
        forTextFieldOrNotifyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        forTextFieldOrNotifyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        forTextFieldOrNotifyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        notifyLabel = UILabel()
        notifyLabel.textAlignment = .center
        notifyLabel.text = "сообщение правильное или не правильное слово"
        notifyLabel.translatesAutoresizingMaskIntoConstraints = false
        forTextFieldOrNotifyView.addSubview(notifyLabel)
        
        notifyLabel.topAnchor.constraint(equalTo: forTextFieldOrNotifyView.topAnchor, constant: 20).isActive = true
        notifyLabel.leadingAnchor.constraint(equalTo: forTextFieldOrNotifyView.leadingAnchor, constant: 20).isActive = true
        notifyLabel.trailingAnchor.constraint(equalTo: forTextFieldOrNotifyView.trailingAnchor, constant: -20).isActive = true
        
        setupNextWordButton()
        
        englishCustomTextField = CustomTextField()
        englishCustomTextField.translatesAutoresizingMaskIntoConstraints = false
        englishCustomTextField.placeholder = "translate"
        forTextFieldOrNotifyView.addSubview(englishCustomTextField)
        englishCustomTextField.borderStyle = .none
        englishCustomTextField.borderInactiveBottomColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        englishCustomTextField.borderActiveBottomColor = #colorLiteral(red: 0.463878572, green: 0.4404314756, blue: 0.9081067443, alpha: 0.9995117188)
        englishCustomTextField.placeholderColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        englishCustomTextField.placeholderFontScale = 0.80
        englishCustomTextField.clipsToBounds = true
        englishCustomTextField.font = UIFont(name: "AvenirNext-medium", size: 20)
        
        englishCustomTextField.topAnchor.constraint(equalTo: notifyLabel.bottomAnchor, constant: 30).isActive = true
        englishCustomTextField.leadingAnchor.constraint(equalTo: forTextFieldOrNotifyView.leadingAnchor, constant: 20).isActive = true
        englishCustomTextField.trailingAnchor.constraint(equalTo: nextWordButton.leadingAnchor, constant: -10).isActive = true
        englishCustomTextField.heightAnchor.constraint(equalTo: forTextFieldOrNotifyView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupAddNewWordButton() {
        addNewWordButton = UIButton(type: .system)
        addNewWordButton.backgroundColor = .systemBlue
        addNewWordButton.translatesAutoresizingMaskIntoConstraints = false
        addNewWordButton.layer.cornerRadius = 25
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: boldConfig)
        addNewWordButton.setImage(image, for: .normal)
        addNewWordButton.tintColor = .white
        
        view.addSubview(addNewWordButton)
        addNewWordButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addNewWordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addNewWordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addNewWordButton.topAnchor.constraint(equalTo: forRussianWordView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func setupNextWordButton() {
        nextWordButton = UIButton(type: .custom)
        nextWordButton.backgroundColor = .systemBlue
        nextWordButton.translatesAutoresizingMaskIntoConstraints = false
        nextWordButton.layer.cornerRadius = 15
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "arrow.up", withConfiguration: boldConfig)
        nextWordButton.setImage(image, for: .normal)
        nextWordButton.tintColor = .white
        
        forTextFieldOrNotifyView.addSubview(nextWordButton)
        nextWordButton.topAnchor.constraint(equalTo: notifyLabel.bottomAnchor, constant: 50).isActive = true
        nextWordButton.trailingAnchor.constraint(equalTo: forTextFieldOrNotifyView.trailingAnchor).isActive = true
        nextWordButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        nextWordButton.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
}

