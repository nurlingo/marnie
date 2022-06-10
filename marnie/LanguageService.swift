//
//  LanguageService.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import Foundation

class LanguageService {
    
    var vocabularyDictionary: [String:[Phrase]]
    var phrasesDictionary: [String:[Phrase]]
    
    var locale: String
    var topic: Topic
    
    init(locale: String, topic: Topic) {
        
        self.locale = locale
        self.topic = topic
        
        vocabularyDictionary = Bundle.main.decode([String:[Phrase]].self, from: "Vocabulary.json")
        phrasesDictionary = Bundle.main.decode([String:[Phrase]].self, from: "Phrase.json")
    }
    
    var words: [String] {
        if let words = vocabularyDictionary[topic.id] {
            return locale == "ru" ? words.map({$0.ru}) : words.map({$0.en})
        }
        return []
    }
    
    var encouragement: String {
        if let phrase = phrasesDictionary["encouragement"]?.randomElement() {
            return locale == "ru" ? phrase.ru : phrase.en
        }
        return ""
        
    }
    
    var greeting: String {
        if let phrase = phrasesDictionary["greeting"]?.randomElement() {
            return locale == "ru" ? phrase.ru : phrase.en
        }
        return ""
    }
    
    var farewell: String {
        if let phrase = phrasesDictionary["farewell"]?.randomElement() {
            return locale == "ru" ? phrase.ru : phrase.en
        }
        return ""
    }
}
    
extension Bundle {
    func decode<T: Decodable>(_ type: T.Type, from file: String, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .deferredToDate, keyDecodingStrategy: JSONDecoder.KeyDecodingStrategy = .useDefaultKeys) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }

        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }

        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        decoder.keyDecodingStrategy = keyDecodingStrategy

        do {
            return try decoder.decode(T.self, from: data)
        } catch DecodingError.keyNotFound(let key, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing key '\(key.stringValue)' not found – \(context.debugDescription)")
        } catch DecodingError.typeMismatch(_, let context) {
            fatalError("Failed to decode \(file) from bundle due to type mismatch – \(context.debugDescription)")
        } catch DecodingError.valueNotFound(let type, let context) {
            fatalError("Failed to decode \(file) from bundle due to missing \(type) value – \(context.debugDescription)")
        } catch DecodingError.dataCorrupted(_) {
            fatalError("Failed to decode \(file) from bundle because it appears to be invalid JSON")
        } catch {
            fatalError("Failed to decode \(file) from bundle: \(error.localizedDescription)")
        }
    }
}
