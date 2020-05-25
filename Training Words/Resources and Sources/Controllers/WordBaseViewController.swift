//
//  WordBaseViewController.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class WordBaseViewController: UIViewController {
    
    var tableView: UITableView!
    
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
                         "обожать (to be)",
                         "интерес (to be)",
                         "улвекаться",
                         "некоторые люди",
                         "праздновать"]
    
    private var weightConfig: UIImage.SymbolConfiguration!
    private var backBarButtonItem: UIBarButtonItem!
    private var addWordBarButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        
        setupTableView()
        setupNavigationController()
        
    }

    
    func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        
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
    
    @objc private func backBarButtomAction(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func addWordkBarButtomAction(_ sender: UIBarButtonItem) {
        

        
        
    }

}

extension WordBaseViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return englishWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WordCell.reuseId, for: indexPath) as! WordCell
        let items = englishWords[indexPath.row]
        let itemRus = russianhWords[indexPath.row]
        cell.englishLabel.text = items
        cell.russianLabel.text = itemRus
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
