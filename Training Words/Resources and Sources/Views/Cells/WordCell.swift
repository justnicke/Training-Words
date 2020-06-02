//
//  WordCell.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class WordCell: UITableViewCell {
    
    // MARK: - Public Properties
    
    static let reuseId = String(describing: WordCell.description())
    let russianLabel = UILabel()
    let englishLabel = UILabel()
    
    // MARK: - Private Properties
    
    private let separateView = UIView()
    
    // MARK: - Constructors
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupLabel() {
        russianLabel.text = "благодоря кому то чему то"
        russianLabel.adjustsFontSizeToFitWidth = true
        russianLabel.minimumScaleFactor = 0
        russianLabel.textAlignment = .center
        
        englishLabel.text = "sfwleflkjDGKRJETHAETHBAETH"
        englishLabel.adjustsFontSizeToFitWidth = true
        englishLabel.textAlignment = .center
        
        separateView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        
        [russianLabel, englishLabel, separateView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0) }
        
        separateView.widthAnchor.constraint(equalToConstant: 1).isActive = true
        separateView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.4).isActive = true
        separateView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        separateView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        englishLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        englishLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        englishLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        englishLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
        
        russianLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        russianLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        russianLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        russianLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.45).isActive = true
    }
}
