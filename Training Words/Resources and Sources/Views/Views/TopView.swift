//
//  TopView.swift
//  Training Words
//
//  Created by Nikita Sukachev on 21.05.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import UIKit

final class TopView: UIView {
    
    // MARK: - Public Properties
    
    var wordTranslateLabel: UILabel!
    
    // MARK: - Constructors
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.layer.shadowOffset = CGSize(width: 0, height: 5)
        self.layer.shadowOpacity = 0.3
        self.layer.shadowRadius = 7
        
        setupWordTranslateLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private Methods
    
    private func setupWordTranslateLabel() {
        wordTranslateLabel = UILabel()
        wordTranslateLabel.textAlignment = .center
        wordTranslateLabel.text = "словосочетание или слово"
        wordTranslateLabel.translatesAutoresizingMaskIntoConstraints = false
        wordTranslateLabel.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        wordTranslateLabel.font = UIFont(name: "AvenirNext-Bold", size: 25)
        wordTranslateLabel.adjustsFontSizeToFitWidth = true
        self.addSubview(wordTranslateLabel)
        
        wordTranslateLabel.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        wordTranslateLabel.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        wordTranslateLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        wordTranslateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
}
