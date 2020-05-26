//
//  WordBaseViewController.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit
import CoreData

final class WordBaseViewController: UIViewController {
    
    // MARK: - Public Properties
    
    var englishWords = ["each other"]
    var russianhWords = ["друг друга"]
    var createdWords: [NewWord] = []
    
    // MARK: - Private Properties
    
    private var tableView: UITableView!
    private var weightConfig: UIImage.SymbolConfiguration!
    private var backBarButtonItem: UIBarButtonItem!
    private var addWordBarButtonItem: UIBarButtonItem!
    private var alertView: AlertView!
    
    // MARK: - Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        
        setupTableView()
        setupNavigationController()
        setupAlertView()
        fetchRequest()
    }
    
    // MARK: - Private Methods
    
    private func setupTableView() {
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.reuseId)
    }
    
    private func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        navigationController?.navigationBar.shadowImage = UIImage()
        
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
            $0?.tintColor = .black
        }
    }
    
    private func setupAlertView() {
        alertView = AlertView(frame: CGRect(x: view.frame.width / 21.99,
                                            y: view.frame.width / 2,
                                            width: view.frame.width / 1.1,
                                            height: view.frame.height / 2.5))
        view.addSubview(alertView)
        alertView.isHidden = true
        alertView.delegate = self
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        alertView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func saveToCoreData(english: String, russian: String) {
        let index = 0
        let newWord = NewWord(context: PersistenceService.context)
        newWord.englishWord = english
        newWord.russianWord = russian
        PersistenceService.saveContext()
        createdWords.insert(newWord, at: index)
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .automatic)
    }
    
    private func deleteWord(indexPath: IndexPath) {
        englishWords.remove(at: indexPath.row)
        russianhWords.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    private func fetchRequest() {
        let fetchRequest: NSFetchRequest<NewWord> = NewWord.fetchRequest()
        
        do {
            let createdWord = try PersistenceService.context.fetch(fetchRequest)
            self.createdWords = createdWord.reversed()
            tableView.reloadData()
        } catch {}
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
        return createdWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.reuseId, for: indexPath) as! WordCell
//        let items = englishWords[indexPath.row]
//        let itemRus = russianhWords[indexPath.row]
        cell.englishLabel.text = createdWords[indexPath.row].englishWord
        cell.russianLabel.text = createdWords[indexPath.row].russianWord
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteWord(indexPath: indexPath)
    }
}

// MARK: - Extension ButtonDelegate

extension WordBaseViewController: ButtonDelegate {
    func cancelButtonTapped(sender: UIButton) {
        alertView.isHidden = true
        dismissKeyboard()
        alertView.engishWordTextField.text?.removeAll()
        alertView.russianWordTextField.text?.removeAll()
    }
    
    func okButtonTapped(sender: UIButton) {
        guard let english = alertView.engishWordTextField.text else { return }
        guard let russian = alertView.russianWordTextField.text else { return }
        
        saveToCoreData(english: english, russian: russian)
        
        alertView.isHidden = true
        dismissKeyboard()
        alertView.engishWordTextField.text?.removeAll()
        alertView.russianWordTextField.text?.removeAll()
    }
}
