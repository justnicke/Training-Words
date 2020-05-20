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
    
    var englishWords = ["each other",
                        "separately",
                        "separate",
                        "fond of",
                        "interested in",
                        "keen on", "some people" ,
                        "celebrate"]
    
    var russianhWords = ["друг друга",
                         "раздельно",
                         "разделять",
                         "обажать (to be)",
                         "интерес (to be)",
                         "улвекаться",
                         "некоторые люди",
                         "праздновать"]
    
    // MARK: - Private Properties
    
    private var forRussianWordView:       UIView!
    private var russianWordLabel:         UILabel!
    private var forTextFieldOrNotifyView: UIView!
    private var notifyLabel:              UILabel!
    private var englishCustomTextField:   CustomTextField!
    private var addNewWordButton:         UIButton!
    private var sendButton:               UIButton!
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupRussianLabelAndView()
        setupTextFieldViewAndNotify()
        setupAddNewWordButton()
        
        russianWordLabel.text = russianhWords.randomElement()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        addNewWordButton.addTarget(self, action: #selector(addNewWordButtonTapped(_:)), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonTapped(_:)), for: .touchUpInside)
        englishCustomTextField.addTarget(self, action: #selector(editingChanged), for: .editingChanged)

    }
    
    // MARK: - Private Methods
    
    private func setupRussianLabelAndView() {
        forRussianWordView = UIView()
        forRussianWordView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        forRussianWordView.translatesAutoresizingMaskIntoConstraints = false
        forRussianWordView.layer.cornerRadius = 10
        forRussianWordView.layer.shadowOffset = CGSize(width: 0, height: 5)
        forRussianWordView.layer.shadowOpacity = 0.3
        forRussianWordView.layer.shadowRadius = 7
        view.addSubview(forRussianWordView)
        
        forRussianWordView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        forRussianWordView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        forRussianWordView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        forRussianWordView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        russianWordLabel = UILabel()
        russianWordLabel.textAlignment = .center
        russianWordLabel.text = "русское словосочетание или слово"
        russianWordLabel.translatesAutoresizingMaskIntoConstraints = false
        russianWordLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        russianWordLabel.font = UIFont(name: "AvenirNext-Bold", size: 25)
        russianWordLabel.adjustsFontSizeToFitWidth = true
        forRussianWordView.addSubview(russianWordLabel)
        
        russianWordLabel.heightAnchor.constraint(equalTo: forRussianWordView.heightAnchor).isActive = true
        russianWordLabel.widthAnchor.constraint(equalTo: forRussianWordView.widthAnchor, multiplier: 0.9).isActive = true
        russianWordLabel.centerYAnchor.constraint(equalTo: forRussianWordView.centerYAnchor).isActive = true
        russianWordLabel.centerXAnchor.constraint(equalTo: forRussianWordView.centerXAnchor).isActive = true
    }
    
    private func setupTextFieldViewAndNotify() {
        forTextFieldOrNotifyView = UIView()
        forTextFieldOrNotifyView.backgroundColor = .clear
        forTextFieldOrNotifyView.translatesAutoresizingMaskIntoConstraints = false
        forTextFieldOrNotifyView.layer.cornerRadius = 10
        view.addSubview(forTextFieldOrNotifyView)
        
        forTextFieldOrNotifyView.topAnchor.constraint(equalTo: forRussianWordView.bottomAnchor, constant: 20).isActive = true
        forTextFieldOrNotifyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        forTextFieldOrNotifyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        forTextFieldOrNotifyView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        notifyLabel = UILabel()
        notifyLabel.textAlignment = .center
        notifyLabel.text = "Correctly"
        notifyLabel.font = UIFont(name: "AvenirNext-medium", size: 20)
        notifyLabel.translatesAutoresizingMaskIntoConstraints = false
        notifyLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
        notifyLabel.alpha = 0
        forTextFieldOrNotifyView.addSubview(notifyLabel)
        
        notifyLabel.topAnchor.constraint(equalTo: forTextFieldOrNotifyView.topAnchor, constant: 30).isActive = true
        notifyLabel.leadingAnchor.constraint(equalTo: forTextFieldOrNotifyView.leadingAnchor, constant: 20).isActive = true
        notifyLabel.trailingAnchor.constraint(equalTo: forTextFieldOrNotifyView.trailingAnchor, constant: -20).isActive = true
        
        setupNextWordButton()
        
        englishCustomTextField = CustomTextField()
        englishCustomTextField.translatesAutoresizingMaskIntoConstraints = false
        englishCustomTextField.placeholder = "enter translate"
        forTextFieldOrNotifyView.addSubview(englishCustomTextField)
        englishCustomTextField.borderStyle = .none
        englishCustomTextField.borderInactiveBottomColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        englishCustomTextField.borderActiveBottomColor = #colorLiteral(red: 0.463878572, green: 0.4404314756, blue: 0.9081067443, alpha: 0.9995117188)
        englishCustomTextField.placeholderColor = #colorLiteral(red: 0.5741485357, green: 0.5741624236, blue: 0.574154973, alpha: 1)
        englishCustomTextField.placeholderFontScale = 0.80
        englishCustomTextField.clipsToBounds = true
        englishCustomTextField.font = UIFont(name: "AvenirNext-medium", size: 25)
        englishCustomTextField.returnKeyType = .send
        englishCustomTextField.enablesReturnKeyAutomatically = true
        englishCustomTextField.delegate = self
        englishCustomTextField.autocapitalizationType = .none
        englishCustomTextField.autocorrectionType = .no
        englishCustomTextField.spellCheckingType = .no
        
        englishCustomTextField.topAnchor.constraint(equalTo: notifyLabel.bottomAnchor, constant: 30).isActive = true
        englishCustomTextField.leadingAnchor.constraint(equalTo: forTextFieldOrNotifyView.leadingAnchor, constant: 20).isActive = true
        englishCustomTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -10).isActive = true
        englishCustomTextField.heightAnchor.constraint(equalTo: forTextFieldOrNotifyView.heightAnchor, multiplier: 0.3).isActive = true
    }
    
    private func setupAddNewWordButton() {
        addNewWordButton = UIButton(type: .system)
        addNewWordButton.backgroundColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        addNewWordButton.translatesAutoresizingMaskIntoConstraints = false
        addNewWordButton.layer.cornerRadius = 25
        addNewWordButton.layer.shadowColor = UIColor.black.cgColor
        addNewWordButton.layer.shadowOffset = CGSize(width: 0, height: 10)
        addNewWordButton.layer.shadowOpacity = 0.2
        addNewWordButton.layer.shadowRadius = 13
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "plus", withConfiguration: boldConfig)
        addNewWordButton.setImage(image, for: .normal)
        addNewWordButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        view.addSubview(addNewWordButton)
        addNewWordButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        addNewWordButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addNewWordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        addNewWordButton.topAnchor.constraint(equalTo: forRussianWordView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func setupNextWordButton() {
        sendButton = UIButton(type: .custom)
        sendButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        sendButton.translatesAutoresizingMaskIntoConstraints = false
        sendButton.layer.cornerRadius = 15
        sendButton.isEnabled = false
        
        let boldConfig = UIImage.SymbolConfiguration(weight: .bold)
        let image = UIImage(systemName: "arrow.up", withConfiguration: boldConfig)
        sendButton.setImage(image, for: .normal)
        sendButton.tintColor = .white
        
        forTextFieldOrNotifyView.addSubview(sendButton)
        sendButton.topAnchor.constraint(equalTo: notifyLabel.bottomAnchor, constant: 50).isActive = true
        sendButton.trailingAnchor.constraint(equalTo: forTextFieldOrNotifyView.trailingAnchor).isActive = true
        sendButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
        sendButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addNewWordButtonTapped(_ sender: UIButton) {
        notifyAnimation()
  
    }
    
    @objc private func sendButtonTapped(_ sender: UIButton) {
        compareTranslations()
    }
    
    @objc func editingChanged() {
        if  englishCustomTextField.text?.isEmpty == false {
            sendButton.isEnabled = true
            sendButton.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        } else {
            sendButton.isEnabled = false
            sendButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        }
    }
    
    func compareTranslations() {
        let find = russianhWords.firstIndex { $0 == russianWordLabel.text }
        let found = englishWords.firstIndex { $0 == englishCustomTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines) }
        
        if find == found {
            russianWordLabel.text = russianhWords.randomElement()
            englishCustomTextField.text?.removeAll()
            notifyAnimation()
        } else if find != found {
            notifyAnimationWrong()
        }
    }
    
    func notifyAnimation() {
        
        UIView.animate(withDuration: 2) {
            self.notifyLabel.text = "Wrong"
            self.notifyLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
            self.notifyLabel.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            UIView.animate(withDuration: 1) {
                self.notifyLabel.alpha = 0
            }
        }


    }
    
    func notifyAnimationWrong() {
        UIView.animate(withDuration: 2) {
            self.notifyLabel.text = "Wrong"
            self.notifyLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
            self.notifyLabel.alpha = 1
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            UIView.animate(withDuration: 1) {
                self.notifyLabel.alpha = 0
            }
        }


    }
}


// MARK: - TextFieldDelegate

extension TrainingViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.isFirstResponder {
            compareTranslations()
        }
        
        return true
    }
}

