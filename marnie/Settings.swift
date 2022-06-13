//
//  Settings.swift
//  marnie
//
//  Created by Daniya on 14/06/2022.
//

import Foundation
import SettingsKit

struct SettingsSectionMarnie: SettingsSection {

    let id: String
    let titleEn: String
    let titleRu: String
    var language: String?
    
    var items: [SettingsItem]
    
    var title: String {
        
        if let language = language,
           language.hasPrefix("ru") {
            return titleRu
        } else {
            return titleEn
        }
    }
    
    
    init(id: String, titleEn: String, titleRu: String, items: [SettingsItemMarnie]) {
        self.id = id
        self.titleEn = titleEn
        self.titleRu = titleRu
        self.items = items
    }

    enum CodingKeys: String, CodingKey {
        case id, titleEn, titleRu, items
    }

    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        id = try values.decode(String.self, forKey: .id)
        titleEn = try values.decode(String.self, forKey: .titleEn)
        titleRu = try values.decode(String.self, forKey: .titleRu)
        items = try values.decode([SettingsItemMarnie].self, forKey: .items)
    }
    
    mutating func setItemsLanguage() {
        var tempItems = items as! [SettingsItemMarnie]
        tempItems = tempItems.map {
            var item = $0
            item.language = language
            return item
        }
        
        items = tempItems
    }
}

struct SettingsItemMarnie: SettingsItem {
    
    let id: String
    let type: String

    let titleEn: String
    let titleRu: String
    var language: String?

    let detailEn: String?
    let detailRu: String?
    
    let urlEn: String?
    let urlRu: String?
    
    let showEn: Int
    let showRu: Int
    
    var title: String {
        if let language = language,
           language.hasPrefix("ru") {
            return titleRu
        } else {
            return titleEn
        }
    }
    
    var detail: String? {
        if let language = language,
           language.hasPrefix("ru") {
            return detailRu
        } else {
            return detailEn
        }
    }
    
    var url: String? {
        
        if let language = language,
           language.hasPrefix("ru") {
            return urlRu
        } else {
            return urlEn
        }
    }
    
    var isShown: Bool {

        if let language = language,
           language.hasPrefix("ru") {
            if showRu == 1 { return true}
            else { return false }
        } else {
            if showEn == 1 { return true}
            else { return false }
        }
    }
    
}

