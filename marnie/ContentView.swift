//
//  ContentView.swift
//  marnie
//
//  Created by Daniya on 22/05/2022.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    let fruits: [String] = [
        "ананас",
        "абрикос",
        "айва",
        "апельсин",
        "арбуз",
        "банан",
        "виноград",
        "гранат",
        "грейпфрут",
        "груша",
        "гуава",
        "дыня",
        "инжир",
        "киви",
        "лимон",
        "манго",
        "персик",
        "помело",
        "финик",
        "хурма"
    ]
    
    @State var gameIsOn = false
    @State var phrase: String = " "
    @State private var input: String = ""
    @FocusState private var isFocused: Bool

    var body: some View {
        
        VStack {
            Text(phrase)
                .font(.title)
                .fontWeight(.bold)
                .padding()
            TextField("", text: $input)
                .multilineTextAlignment(.center)
                .font(.title)
                .disableAutocorrection(true)
                .textCase(.lowercase)
                .autocapitalization(.none)
                .focused($isFocused)
                .onChange(of: input) { [input] newValue in
                    
                    if self.phrase.hasPrefix(newValue) {
                        self.input = newValue
                        
                        let diffInLength = newValue.count - input.count
                        if diffInLength > 0 && diffInLength <= newValue.count {
                            utter(String(newValue.suffix(diffInLength)))
                        }
                        
                        // pronounce letter
                    } else {
                        self.input = input
                    }
                    
                    if self.phrase == newValue {
                        isFocused = false
                        
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            utterSlowly(phrase)
                            gameIsOn = false
                        }
                        // game won
                        // pronounce the word
                        // go to next phrase
                    }
                }
            if !gameIsOn {
                Spacer()
                Button(action: {
                    startNewGame()
                }) {
                    Text("New game")
                        .padding()
                        .font(.title)
                        .foregroundColor(.white)
                        .background(.blue)
                        .cornerRadius(15)
                    }
                }
                
            Spacer()
        }
    }
    
    func startNewGame() {
        self.phrase = fruits.randomElement() ?? "NULL"
        self.input = ""
        self.gameIsOn = true
        self.isFocused = true
    }
    
    func utter(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")

        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }
    
    func utterSlowly(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ru")

        utterance.rate = 0.4
        
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
