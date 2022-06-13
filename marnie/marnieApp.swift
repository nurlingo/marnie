//
//  marnieApp.swift
//  marnie
//
//  Created by Daniya on 22/05/2022.
//

import SwiftUI

let locale: String = Locale.current.identifier == "ru" ? "ru" : "en"

@main
struct marnieApp: App {
    var body: some Scene {
        WindowGroup {
            MainView().onAppear {
                let ss = SpeechService(language: locale)
                let ps = PhraseService(language: locale)
                ss.utterSlowly(ps.greeting)
            }
        }
    }
}
