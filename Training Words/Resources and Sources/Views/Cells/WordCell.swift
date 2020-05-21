//
//  WordCell.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class WordCell: UITableViewCell {
    
    static let reuseId = String(describing: WordCell.description())
    
    let russianLabel = UILabel()
    let englishLabel = UILabel()
    let separateView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    
        self.layer.cornerRadius = 10
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let padding = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        bounds = bounds.inset(by: padding)
    }
    
    func setup() {
        
        russianLabel.text = "благодоря кому то чему то"
        russianLabel.adjustsFontSizeToFitWidth = true
        russianLabel.minimumScaleFactor = 0
        
        russianLabel.textAlignment = .center
        
        
        englishLabel.text = "sfwleflkjDGKRJETHAETHBAETH"
        englishLabel.adjustsFontSizeToFitWidth = true
        englishLabel.textAlignment = .center
        
        
        separateView.backgroundColor = .black
        
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
