//
//  SpeechService.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import Foundation
import AVFoundation


class SpeechService {
    
    let ls: LanguageService
        
    private let synthesizer = AVSpeechSynthesizer()
    
    init(ls: LanguageService) {
        self.ls = ls
    }
    
    func setDelegate(_ delegate: AVSpeechSynthesizerDelegate) {
        synthesizer.delegate = delegate
    }
    
    var queue: [String] = []
    
    func utter(_ text: String) {
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = AVSpeechSynthesisVoice(language: self.ls.locale)
            utterance.rate = 0.5
            self.synthesizer.speak(utterance)
        }
    }
    
    func utterSlowly(_ text: String, addition: String = "") {
        DispatchQueue.global(qos: .userInitiated).async {
            let utterance = AVSpeechUtterance(string: text + ". " + addition)
            utterance.voice = AVSpeechSynthesisVoice(language: self.ls.locale)
            utterance.rate = 0.4
            
            self.synthesizer.speak(utterance)
        }
    }
    
}
