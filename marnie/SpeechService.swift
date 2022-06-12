//
//  SpeechService.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import Foundation
import AVFoundation


class SpeechService {
    
    let locale: String
        
    private let synthesizer = AVSpeechSynthesizer()
    
    init(locale: String) {
        self.locale = locale
    }
    
    func setDelegate(_ delegate: AVSpeechSynthesizerDelegate) {
        synthesizer.delegate = delegate
    }
    
    var queue: [String] = []
    
    func utter(_ text: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: self.locale)
            utterance.rate = 0.5
            self.synthesizer.speak(utterance)
        }
    }
    
    func utterSlowly(_ text: String, addition: String = "") {
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text + ". " + addition)
            utterance.voice = AVSpeechSynthesisVoice(language: self.locale)
            utterance.rate = 0.4
            
            self.synthesizer.speak(utterance)
        }
    }
    
}
