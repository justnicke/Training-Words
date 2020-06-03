//
//  Storage.swift
//  Training Words
//
//  Created by Nikita Sukachev on 03.06.2020.
//  Copyright © 2020 Nikita Sukachev. All rights reserved.
//

import Foundation

struct UserDefaultsKeys {
    static let russianWords = "russianWords"
    static let englishWords = "englishWords"
}

final class Storage {
    
    /// Get the word from the storage
    static func words() -> (en: [String], ru: [String]) {
        if let enWords = UserDefaults.standard.array(forKey: UserDefaultsKeys.englishWords) as? [String],
           let ruWords = UserDefaults.standard.array(forKey: UserDefaultsKeys.russianWords) as? [String] {
            return (en: enWords, ru: ruWords)
        } else {
            return (en:[], ru: [])
        }
    }
    
    /// Saves new words to storage
    static func save(englishWord: [String], russianWord: [String]) {
        UserDefaults.standard.set(englishWord, forKey: UserDefaultsKeys.englishWords)
        UserDefaults.standard.set(russianWord, forKey: UserDefaultsKeys.russianWords)
    }
    
    /// Deleting the selected word from storage
    static func remove(from array: [String], by key: String, selectedWord: String) {
        var words = array
        words = UserDefaults.standard.stringArray(forKey: key) ?? [String]()
        if words.contains(selectedWord) {
            words.remove(at: words.firstIndex(of: selectedWord)!)
        }
        UserDefaults.standard.set(words, forKey: key)
    }
}
