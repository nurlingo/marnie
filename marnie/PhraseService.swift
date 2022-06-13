//
//  PhraseService.swift
//  marnie
//
//  Created by Daniya on 12/06/2022.
//

import Foundation

class PhraseService {
    
    var phrasesDictionary: [String:[Phrase]]
    
    var language: String
    
    init(language: String) {
        self.language = language
        phrasesDictionary = Bundle.main.decode([String:[Phrase]].self, from: "Phrase.json")
    }
    
    var encouragement: String {
        if let phrase = phrasesDictionary["encouragement"]?.randomElement() {
            return language == "ru" ? phrase.ru : phrase.en
        }
        return ""
        
    }
    
    var lessonStarted: String {
        if let phrase = phrasesDictionary["lessonStarted"]?.randomElement() {
            return language == "ru" ? phrase.ru : phrase.en
        }
        return ""
    }
    
    var greeting: String {
        if let phrase = phrasesDictionary["greeting"]?.randomElement() {
            return language == "ru" ? phrase.ru : phrase.en
        }
        return ""
    }
    
    var farewell: String {
        if let phrase = phrasesDictionary["farewell"]?.randomElement() {
            return language == "ru" ? phrase.ru : phrase.en
        }
        return ""
    }
}
