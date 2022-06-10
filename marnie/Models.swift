//
//  Models.swift
//  marnie
//
//  Created by Daniya on 04/06/2022.
//

import Foundation

struct Topic: Decodable, Identifiable {
    let id: String
    let en: String
    let ru: String
    
}

struct Phrase: Decodable {
    let en: String
    let ru: String
}

