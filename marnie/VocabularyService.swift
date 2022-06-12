//
//  LanguageService.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import Foundation

class VocabularyService {
    
    var topicVocabulary: [Vocabulary]
    
    var locale: String
    var topic: Topic
    
    init(locale: String, topic: Topic) {
        
        self.locale = locale
        self.topic = topic
        
        let allTopics = Bundle.main.decode([String:[Vocabulary]].self, from: "Vocabulary.json")
        topicVocabulary = allTopics[topic.id]?.filter({ !$0.emoji.isEmpty }).shuffled() ?? []
    }
    
    var topicTitle: String {
        locale == "ru" ? topic.ru : topic.en
    }
    
    var words: [String] {
        locale == "ru" ? topicVocabulary.map({$0.ru}) : topicVocabulary.map({$0.en})
    }
    
    var emojis: [String] {
        topicVocabulary.map({$0.emoji})
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
