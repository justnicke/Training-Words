//
//  TrainingViewController.swift
//  Training Words
//
//  Created by Nikita Sukachev on 19.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import CoreData
import GameplayKit

final class TrainingViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var topView: TopView!
    var englishWords = [String]()
    var russianhWords = [String]()
    
    // MARK: - Private Properties
    
    private var bottomView: BottomView!
    private var addNewWordButton: UIButton!
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        setupTopAndBottomView()
        setupAddNewWordButton()
        fetchRequest()
        
        topView.wordTranslateLabel.text = russianhWords.randomElement()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        addNewWordButton.addTarget(self, action: #selector(addNewWordButtonAction(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        chekingLabel()
    }
    
    // MARK: - Private Methods
    
    private func fetchRequest() {
        let fetchRequest: NSFetchRequest<NewWord> = NewWord.fetchRequest()
        
        do {
            let createdWord = try PersistenceService.context.fetch(fetchRequest)
            englishWords = createdWord.compactMap { $0.englishWord }
            russianhWords = createdWord.compactMap { $0.russianWord }
        } catch {}
    }
    
    private func setupTopAndBottomView() {
        topView = TopView()
        bottomView = BottomView()
        bottomView.englishCustomTextField.delegate = self
        
        [topView, bottomView].forEach { view.addSubview($0) }
        
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        topView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        topView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
        
        bottomView.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 20).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        bottomView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.2).isActive = true
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
        addNewWordButton.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: -20).isActive = true
    }
    
    private func compareTranslations() {
        let indexRussianСollection = russianhWords.firstIndex {
            $0 == topView.wordTranslateLabel.text
        }
        let indexEnglishСollection = englishWords.firstIndex {
            $0 == bottomView.englishCustomTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if indexRussianСollection == indexEnglishСollection {
            let distribution = GKShuffledDistribution(lowestValue: russianhWords.startIndex, highestValue: russianhWords.endIndex - 1)
            topView.wordTranslateLabel.text = russianhWords[distribution.nextInt()]
            
            bottomView.englishCustomTextField.text?.removeAll()
            notifyResult(translate: true)
        } else if indexRussianСollection != indexEnglishСollection {
            notifyResult(translate: false)
        }
    }
    
    private func notifyResult(translate: Bool) {
        switch translate {
        case true:
            UIView.animate(withDuration: 1) {
                self.bottomView.notificationLabel.text = "Correctly"
                self.bottomView.notificationLabel.textColor = #colorLiteral(red: 0.4666666687, green: 0.7647058964, blue: 0.2666666806, alpha: 1)
                self.bottomView.notificationLabel.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                UIView.animate(withDuration: 1) {
                    self.bottomView.notificationLabel.alpha = 0
                }
            }
        case false:
            UIView.animate(withDuration: 1) {
                self.bottomView.notificationLabel.text = "Wrong"
                self.bottomView.notificationLabel.textColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
                self.bottomView.notificationLabel.alpha = 1
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
                UIView.animate(withDuration: 1) {
                    self.bottomView.notificationLabel.alpha = 0
                }
            }
        }
    }
    
    private func chekingLabel() {
        if russianhWords.isEmpty == true {
            bottomView.englishCustomTextField.isHidden = true
            topView.wordTranslateLabel.text = "Create new words"
        } else {
            bottomView.englishCustomTextField.isHidden = false
        }
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addNewWordButtonAction(_ sender: UIButton) {
        let navigationController = UINavigationController(rootViewController: WordBaseViewController())
        navigationController.modalPresentationStyle = .fullScreen
        present(navigationController, animated: true, completion: nil)
        bottomView.englishCustomTextField.text?.removeAll()
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



