//
//  GameView.swift
//  marnie
//
//  Created by Daniya on 22/05/2022.
//

import SwiftUI
import AVFoundation

struct GameView: View {
    
    @StateObject var vm: GameViewModel
    @FocusState private var isFocused: Bool
    @State private var playerInput: String = ""
    
    var body: some View {
        
        VStack {
            Text(vm.emoji)
                .font(Font.system(size: 110))
                .padding()
            Text(vm.phrase)
                .font(Font.largeTitle)
                .fontWeight(.bold)
                .padding()
                .onChange(of: vm.phrase) { _ in
                    self.playerInput = ""
                }
            TextField("", text: $playerInput)
                .multilineTextAlignment(.center)
                .font(Font.largeTitle)
                .textCase(.lowercase)
                .autocapitalization(.none)
                .focused($isFocused)
                .disableAutocorrection(true)
                .onChange(of: playerInput) { [playerInput] newValue in
                    vm.playerInputDidChange(from: playerInput, to: newValue)
                    self.playerInput = vm.playerInput
                }
            Spacer()
        }.onAppear {
            vm.startNewGame()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.isFocused = true
            }
        }
    }
}

class GameViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {

    @Published var emoji: String = ""
    @Published var phrase: String = " "
    @Published var imageUrls = [String]()
    fileprivate var playerInput: String = ""
    let vs: VocabularyService
    let ss: SpeechService
    let ps: PhraseService
    
    init(vs: VocabularyService, ss: SpeechService, ps: PhraseService) {
        self.vs = vs
        self.ss = ss
        self.ps = ps
    }
    
    private var words = [String]()
    private var emojis = [String]()
    
    func startNewGame() {
        words = vs.words
        emojis = vs.emojis
        ss.setDelegate(self)
        ss.utterSlowly(ps.lessonStarted, addition: vs.topicTitle)
    }
    
    func goToNextPhrase() {
        
        if words.count > 0 {
            self.phrase = words.removeLast()
            
            let emoji = emojis.removeLast()
            self.emoji = emoji.isEmpty ? "?" : emoji
            
        } else {
            ss.utterSlowly(ps.farewell)
            UserDefaults.standard.set(true, forKey: "\(vs.topic.id)_\(vs.locale)")
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                fatalError()
            }
        }
        
        
    }
    
    func playerInputDidChange(from oldValue: String, to newValue: String) {
        if newValue.isEmpty {
            playerInput = ""
        } else if phrase.hasPrefix(newValue) {
            
            let diffInLength = newValue.count - oldValue.count
            if diffInLength > 0 && diffInLength <= newValue.count {
                ss.utter(String(newValue.suffix(diffInLength)))
                playerInput = newValue
            }
            
        } else {
            playerInput = oldValue
        }
        
    }
    
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        if utterance.rate == 0.4 {
            self.goToNextPhrase()
        } else if phrase == playerInput {
            playerInput = ""
            ss.utterSlowly(
                self.phrase,
                addition: ps.encouragement
            )
            // pronounce the word
            // go to next phrase
        }
    }
    
}
