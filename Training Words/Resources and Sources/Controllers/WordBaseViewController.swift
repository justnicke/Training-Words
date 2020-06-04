//
//  WordBaseViewController.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class WordBaseViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private var weightConfig: UIImage.SymbolConfiguration!
    private var backBarButtonItem: UIBarButtonItem!
    private var addWordBarButtonItem: UIBarButtonItem!
    private var alertView: AlertView!
    private var englishWords: [String] = []
    private var russianWords: [String] = []
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light
        view.backgroundColor = .clear
        
        setupTableView()
        setupNavigationController()
        setupAlertView()
        getWordsFromUserDefaults()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.tableFooterView = UIView()
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.reuseId)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "AvenirNext-DemiBold", size: 17)!]
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        
        navigationItem.title = "Word Base"
        
        weightConfig = UIImage.SymbolConfiguration(weight: .bold)
        let backImage = UIImage(systemName: "chevron.left", withConfiguration: weightConfig)
        backBarButtonItem = UIBarButtonItem(image: backImage,
                                            style: .plain,
                                            target: self,
                                            action: #selector(backBarButtomAction(_:)))
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        weightConfig = UIImage.SymbolConfiguration(weight: .bold)
        let addImage = UIImage(systemName: "plus", withConfiguration: weightConfig)
        addWordBarButtonItem = UIBarButtonItem(image: addImage,
                                               style: .plain,
                                               target: self,
                                               action: #selector(addWordkBarButtomAction(_:)))
        navigationItem.rightBarButtonItem = addWordBarButtonItem
        
        [addWordBarButtonItem, backBarButtonItem].forEach {
            $0?.tintColor = .white
        }
    }
    
    private func setupAlertView() {
        alertView = AlertView(frame: CGRect(x: view.frame.width / 21.99,
                                            y: view.frame.width / 3,
                                            width: view.frame.width / 1.1,
                                            height: view.frame.height / 2.5))
        view.addSubview(alertView)
        alertView.isHidden = true
        alertView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        alertView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func saveNewWord() {
        guard let english = alertView.engishWordTextField.text else { return }
        guard let russian = alertView.russianWordTextField.text else { return }
        
        let index = 0
        englishWords.insert(english, at: index)
        russianWords.insert(russian, at: index)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
        
        Storage.save(englishWord: englishWords, russianWord: russianWords)
    }
    
    private func deleteWord(indexPath: IndexPath) {
        let enWord = englishWords[indexPath.row]
        Storage.remove(from: englishWords, by: UserDefaultsKeys.englishWords, selectedWord: enWord)
        
        let ruWord = russianWords[indexPath.row]
        Storage.remove(from: russianWords, by: UserDefaultsKeys.russianWords, selectedWord: ruWord)
        
        englishWords.remove(at: indexPath.row)
        russianWords.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func getWordsFromUserDefaults() {
        let word = Storage.words()
        englishWords = word.en
        russianWords = word.ru
    }
    
    @objc private func backBarButtomAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addWordkBarButtomAction(_ sender: UIBarButtonItem) {
        alertView.isHidden = false
    }
    
    @objc private func dismissKeyboard() {
        alertView.endEditing(true)
    }
}

// MARK: - Extension TableViewDataSource and Delegate

extension WordBaseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return englishWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.reuseId, for: indexPath) as! WordCell
        cell.englishLabel.text = englishWords[indexPath.row]
        cell.russianLabel.text = russianWords[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteWord(indexPath: indexPath)
        }
    }
}

// MARK: - Extension TappedButtonAlertDelegate

extension WordBaseViewController: TappedButtonAlertDelegate {
    func cancelButtonTapped(sender: UIButton) {
        alertView.isHidden = true
        dismissKeyboard()
        alertView.engishWordTextField.text?.removeAll()
        alertView.russianWordTextField.text?.removeAll()
    }
    
    func okButtonTapped(sender: UIButton) {
        saveNewWord()
        
        alertView.isHidden = true
        dismissKeyboard()
        alertView.engishWordTextField.text?.removeAll()
        alertView.russianWordTextField.text?.removeAll()
    }
}
