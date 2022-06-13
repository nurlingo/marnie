//
//  MainView.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var languageIndex: Int = {
        locale == "ru" ? 0 : 1
    }()
    
    let topics = Bundle.main.decode([Topic].self, from: "Topics.json")
    
    var language: String {
        languageIndex == 0 ? "ru" : "en"
    }
    
    var title: String {
        languageIndex == 0 ? "Темы на выбор" : "Topics to choose"
    }
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Picker("Choose Language", selection: $languageIndex) {
                    Text("Русский").tag(0).font(.title)
                    Text("English").tag(1).font(.title)
                }
                .pickerStyle(.segmented)
                
                ForEach(topics) { topic in
                    NavigationLink {
                        let vs = VocabularyService(language: language, topic: topic)
                        let ss = SpeechService(language: language)
                        let ps = PhraseService(language: language)
                        let gameVM = GameViewModel(vs: vs, ss: ss, ps: ps)
                        GameView(vm: gameVM)
                    } label: {
                        HStack {
                            if UserDefaults.standard.bool(forKey: "\(topic.id)_\(language)") {
                                Text("✅").font(.title)
                            }
                            Text(language == "ru" ? topic.ru : topic.en)
                                .font(.title)
                            if UserDefaults.standard.bool(forKey: "\(topic.id)_\(language)") {
                                Text("✅").font(.title)
                            }
                        }
                        
                    }
                }.navigationTitle(title)
                
            }
            
        }
    }
    
}
