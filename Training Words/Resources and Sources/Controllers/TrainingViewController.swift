//
//  TrainingViewController.swift
//  Training Words
//
//  Created by Nikita Sukachev on 19.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import GameplayKit

final class TrainingViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var topView: TopView!
//    var englishWords = [String]()
//    var russianWords = [String]()
    
    var englishWords = ["the costs",
                        "get tired",
                        "achieve",
                        "aim",
                        "think it over",
                        "grateful to",
                        "some",
                        "explain to",
                        "repair",
                        "something",
                        "follow",
                        "greatly",
                        "disappointed",
                        "forgive",
                        "hurry up",
                        "lend",
                        "somehow",
                        "borrow",
                        "authorities",
                        "apologize",
                        "devote",
                        "confuse",
                        "regret",
                        "measures",
                        "punish",
                        "pass",
                        "lead to",
                        "interrupt",
                        "take part",
                        "compete", "influence", "anymore", "deny", "insist", "notice", "absence", "the only", "approach", "react to", "fly to", "produce", "will be able", "could", "manage", "belong to", "whose", "mention", "pronunciation", "catch", "guess", "look up", "look at", "impress", "at last", "express", "satisfy", "satisfaction", "attitude to", "point at", "last forever", "the day after tomorrow", "in the beginning", "in the end", "at the beginning", "at the end", "available", "get dark", "sign", "threat"]
    var russianWords = ["издержки",
                        "уставать",
                        "достигать",
                        "цель",
                        "обдумывать это",
                        "благодарны кому-то",
                        "несколько / некоторые",
                        "объяснять кому-то",
                        "починить",
                        "что-то",
                        "следовать, последовать",
                        "очень сильно",
                        "расстроенный, разочарованный",
                        "простить",
                        "торопиться / спешить",
                        "одолжить",
                        "как-то",
                        "занимать",
                        "власти",
                        "извиняться",
                        "уделять",
                        "путать",
                        "желеть / пожелеет",
                        "меры",
                        "наказать",
                        "проходить / сдавать",
                        "привести к чему-то",
                        "перебивать",
                        "принемать участие", "конкурировать", "влиять", "более / больше (в отрицании)", "отрицать", "настаивать", "замечать", "отсутствие", "единственный", "подход", "реагировать на что-то", "лететь в", "производить", "смочь", "мог", "суметь", "принадлежать кому-то", "чей", "упоминать", "произношение", "поймать, ловить", "отгадать", "посмотреть где-то", "посмотреть на кого-то / что-то", "впечатлять", "наконец", "выражать", "удовлетворять", "удвалетворение", "отношение к кому чему-то", "указывать на что-то", "длится вечно", "после завтра", "в начале", "в конце", "в начале чего-то", "в конце чего-то", "доступен, доступен", "темнеть", "подписать", "угроза"]
    
    let helpButton = UIButton(type: .system)
    let promptButton = UIButton(type: .system)
    var сountTaps = 0
    
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
        setupHelpersAndPromptButtons()
        
        topView.wordTranslateLabel.text = russianWords.randomElement()
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        
        addNewWordButton.addTarget(self, action: #selector(addNewWordButtonAction(_:)), for: .touchUpInside)
        
        helpButton.addTarget(self, action: #selector(helpButtonTapped(_:)), for: .touchUpInside)
        promptButton.addTarget(self, action: #selector(promptButtonTapped(_:)), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        getWordsFromUserDefaults()
        chekingLabel()
    }
        
    // MARK: - Private Methods
    
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
        let indexRussianСollection = russianWords.firstIndex {
            $0 == topView.wordTranslateLabel.text
        }
        let indexEnglishСollection = englishWords.firstIndex {
            $0 == bottomView.englishCustomTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        
        if indexRussianСollection == indexEnglishСollection {
            let distribution = GKShuffledDistribution(lowestValue: russianWords.startIndex, highestValue: russianWords.endIndex - 1)
            topView.wordTranslateLabel.text = russianWords[distribution.nextInt()]
            
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
                self.helpButton.setTitle("Help", for: .normal)
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
        if russianWords.isEmpty == true {
            bottomView.englishCustomTextField.isHidden = true
            topView.wordTranslateLabel.text = "Create new words"
        } else {
            bottomView.englishCustomTextField.isHidden = false
        }
    }
    
    private func getWordsFromUserDefaults() {
        let word = Storage.words()
        englishWords = word.en
        russianWords = word.ru
        topView.wordTranslateLabel.text = russianWords.randomElement()
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

extension TrainingViewController {
    
    @objc private func helpButtonTapped(_ sender: UIButton) {
        let indexRussianСollection = russianWords.firstIndex { $0 == topView.wordTranslateLabel.text }
//        print(englishWords[indexRussianСollection!])
        
        helpButton.setTitle(englishWords[indexRussianСollection!], for: .normal)
    }
    
    @objc private func promptButtonTapped(_ sender: UIButton) {
        let indexRussianСollection = russianWords.firstIndex { $0 == topView.wordTranslateLabel.text }
        let word = englishWords[indexRussianСollection!]
        
        сountTaps += 1
        
        var count = сountTaps 
        
        
        promptButton.setTitle(word, for: .normal)
        
        let i = word.index(word.startIndex, offsetBy: count)
        let char = word[i]
        print(char)
        
        if сountTaps == word.count {
            promptButton.setTitle("Show a letter", for: .normal)
            сountTaps = 0
        }
    }
    
    func promptChar(touchNum: Int, word: String) {
        
        let i = word.index(word.startIndex, offsetBy: touchNum)
        
        
    }
    
    private func setupHelpersAndPromptButtons() {
        [helpButton, promptButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor = .systemBlue
            $0.tintColor = .white
            $0.layer.cornerRadius = 10
            view.addSubview($0)
        }
        
        helpButton.setTitle("Help", for: .normal)
        helpButton.topAnchor.constraint(equalTo: bottomView.bottomAnchor, constant: 10).isActive = true
        helpButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        helpButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        helpButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        promptButton.setTitle("Show a letter", for: .normal)
        promptButton.topAnchor.constraint(equalTo: helpButton.bottomAnchor, constant: 10).isActive = true
        promptButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        promptButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        promptButton.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
    }
    
    
}
