//
//  ContentView.swift
//  marnie
//
//  Created by Daniya on 22/05/2022.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    @StateObject private var vm = SpellingViewModel()
    @FocusState fileprivate var isFocused: Bool
    @State private var playerInput: String = ""
    
    var body: some View {
        
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(vm.imageUrls, id: \.self) { imageUrl in
                        AsyncImage(url: URL(string: imageUrl)) { image in
                            image.resizable()
                        } placeholder: {
                            Color.gray
                        }
                        .frame(width: 250, height: 250)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
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

extension ContentView {
    
    class SpellingViewModel: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {

        @Published fileprivate var gameIsOn = false
        @Published fileprivate var phrase: String = " "
        @Published fileprivate var imageUrls = [String]()
        fileprivate var playerInput: String = ""
        private let synthesizer = AVSpeechSynthesizer()
        
        var category = ""
        var words = [String]()
        var locale = Locale.current.identifier
        var encouragement: String {
            encouragementDictionary[locale]?.randomElement() ?? ""
        }
        
        func startNewGame() {
            gameIsOn = true
            
            category = contentDictionary.keys.randomElement() ?? ""
            
            locale = localeDictionary[category] ?? ""
            words = contentDictionary[category]?.shuffled() ?? []
            synthesizer.delegate = self
            
            let greeting = greetingDictionary[locale]?.randomElement() ?? ""
            
            utterSlowly(greeting)
                        
        }
        
        func goToNextPhrase() {
            
            if words.count > 0 {
                phrase = words.removeLast()
                let querry = phrase + " " + category
                VisualizerHelper.shared.requestImagesFromGoogle(querry: querry, handler: self.handleImages)
            } else {
                let farewell = farewellDictionary[locale]?.randomElement() ?? ""
                utterSlowly(farewell)
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
                    utter(String(newValue.suffix(diffInLength)))
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
                let textToUtter = self.phrase
                self.utterSlowly(textToUtter, addition: self.encouragement)
                // pronounce the word
                // go to next phrase
            }
        }
        
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
        
        func handleImages(response: GoogleResponse?, error: GenericError?) {
            
            if let error = error {
                print(#function, "error getting the imageItems remotly -> \(error.type) \(error.description)")
                return
            }
            
            guard let response = response else {
                print(#function, "imageItems are nil")
                return
            }
            
            DispatchQueue.main.async {
                self.imageUrls = response.items.map{ $0.link }.shuffled()
            }
            
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
