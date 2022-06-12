//
//  MainView.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import SwiftUI

struct MainView: View {
    
    @State var localeIndex: Int = {
        Locale.current.identifier == "ru" ? 0 : 1
    }()
    
    let topics = Bundle.main.decode([Topic].self, from: "Topics.json")
    
    var locale: String {
        localeIndex == 0 ? "ru" : "en"
    }
    
    var title: String {
        localeIndex == 0 ? "Темы на выбор" : "Topics to choose"
    }
    
    
    var body: some View {
        
        NavigationView {
            
            ScrollView(.vertical, showsIndicators: false) {
                
                Picker("Choose Language", selection: $localeIndex) {
                    Text("Русский").tag(0).font(.title)
                    Text("English").tag(1).font(.title)
                }
                .pickerStyle(.segmented)
                
                ForEach(topics) { topic in
                    NavigationLink {
                        let vs = VocabularyService(locale: locale, topic: topic)
                        let ss = SpeechService(locale: locale)
                        let ps = PhraseService(locale: locale)
                        let gameVM = GameViewModel(vs: vs, ss: ss, ps: ps)
                        GameView(vm: gameVM)
                    } label: {
                        HStack {
                            if UserDefaults.standard.bool(forKey: "\(topic.id)_\(locale)") {
                                Text("✅").font(.title)
                            }
                            Text(locale == "ru" ? topic.ru : topic.en)
                                .font(.title)
                            if UserDefaults.standard.bool(forKey: "\(topic.id)_\(locale)") {
                                Text("✅").font(.title)
                            }
                        }
                        
                    }
                }.navigationTitle(title)
                
            }.onAppear {
                let ss = SpeechService(locale: locale)
                let ps = PhraseService(locale: locale)
                ss.utterSlowly(ps.greeting)
            }
    
            
        }
    }
    
}
