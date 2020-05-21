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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.866422236, green: 0.9141893983, blue: 0.9915274978, alpha: 1)
        
        setupTableView()
    }

    
    func setupTableView() {
        tableView = UITableView()
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none

        
        tableView.register(WordCell.self, forCellReuseIdentifier: WordCell.reuseId)
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
