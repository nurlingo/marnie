let basmala = "بسم الله الرحمن الرحيم"
//
//  marnieApp.swift
//  marnie
//
//  Created by Daniya on 22/05/2022.
//

import SwiftUI
import PersonalizationKit

@main
struct marnieApp: App {
    
    @State var counter = 0
    
    var body: some Scene {
        WindowGroup {
            
            if counter == 0 {
                NavigationView {
                    PersonalizationQuestionView(
                        assets: viewAssets,
                        completePersonalization: { self.counter += 1 },
                        questions: questions,
                        storage: Storage(),
                        question: questions[0]
                    ).transition(.opacity)
                }
                
            } else {
                MainView()
                    .environmentObject(ViewRouter())
                    .onAppear {
                        let locale: String = Locale.current.identifier == "ru" ? "ru" : "en"
                        let ss = SpeechService(language: locale)
                        let ps = PhraseService(language: locale)
                        ss.utterSlowly(ps.greeting)
                }
            }
            
            
           
        }
    }
}
