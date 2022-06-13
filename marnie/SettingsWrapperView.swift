//
//  SettingsWrapperView.swift
//  marnie
//
//  Created by Daniya on 14/06/2022.
//

import SwiftUI
import SettingsKit

struct SettingsWrapperView: UIViewControllerRepresentable, SettingsViewDelegate {
    
    let language: String
    @EnvironmentObject var viewRouter: ViewRouter

    
    typealias UIViewControllerType = SettingsView

    func makeUIViewController(context: Context) -> SettingsView {
        let settingsSections: [SettingsSectionMarnie] = Bundle.main.decode([SettingsSectionMarnie].self, from: "Settings.json")
            .map {
                var section = $0
                section.language = language
                section.setItemsLanguage()
                return section
            }
        
        let settingsPage = SettingsBuilder(
            analytics: nil,
            settingsSections: settingsSections,
            notificationControlPanel: nil,
            notificationLocalSchedule: nil,
            settingsStyleConfigurable: nil
        )
        
        settingsPage.settingsView.settingsViewDelegate = self
        
        return settingsPage.settingsView
    }
    
    func updateUIViewController(_ uiViewController: SettingsView, context: Context) {
    }
    
    func openDonateProposition() {
        viewRouter.willMoveToDonationScreen = true
    }
 }

