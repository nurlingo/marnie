//
//  MainView.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import SwiftUI

struct MainView: View {
    
    let topics = Bundle.main.decode([Topic].self, from: "Topics.json")
    
    var title: String {
        localeIndex == 0 ? "Темы на выбор" : "Topics to choose"
    }

    @State var localeIndex: Int = {
        0
//        Locale.current.identifier == "ru" ? 0 : 1
    }()
    
    var locale: String {
        localeIndex == 0 ? "ru" : "en"
    }
    
    var body: some View {
        
        NavigationView {
        ScrollView(.vertical, showsIndicators: false) {
            
                Picker("Choose App Language", selection: $localeIndex) {
                    Text("Русский").tag(0)
                    Text("English").tag(1)
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
                        Text(localeIndex == 0 ? topic.ru : topic.en)
                            .font(.title)
                    }
                }.navigationTitle(title)
                
            }
        }.onAppear {
            let ss = SpeechService(locale: locale)
            let ps = PhraseService(locale: locale)
            ss.utterSlowly(ps.greeting)
        }
    }
    
}
