let basmala = "بسم الله الرحمن الرحيم"
//
//  marnieApp.swift
//  marnie
//
//  Created by Daniya on 22/05/2022.
//

import SwiftUI

@main
struct marnieApp: App {
    var body: some Scene {
        WindowGroup {
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
