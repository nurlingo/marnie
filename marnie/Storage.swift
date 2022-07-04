//
//  Storage.swift
//  marnie
//
//  Created by Daniya on 04/07/2022.
//

import SwiftUI
import PersonalizationKit

struct Storage: PersonalizationStorage {
    func addCheckedOption(_ question: QuestionData, option: OptionData) {
        
        let storageID = "checkBoxQuestionID_\(question.id)"
        if var checkedOptions = UserDefaults.standard.array(forKey: storageID) as? [Int] {
            checkedOptions.append(option.id)
            checkedOptions = Array(Set(checkedOptions))
            UserDefaults.standard.set(checkedOptions, forKey: storageID)
        } else {
            UserDefaults.standard.set([option.id], forKey: storageID)
        }
        UserDefaults.standard.synchronize()
                
    }

    func removeCheckedOption(_ question: QuestionData, option: OptionData) {
        let storageID = "checkBoxQuestionID_\(question.id)"
        if var checkedOptions = UserDefaults.standard.array(forKey: storageID) as? [Int] {
            var set = Set(checkedOptions)
            set.remove(option.id)
            checkedOptions = Array(set)
            UserDefaults.standard.set(checkedOptions, forKey: storageID)
            UserDefaults.standard.synchronize()
        }
    }
    
    func isOptionChecked(_ question: QuestionData, option: OptionData) -> Bool {
        let storageID = "checkBoxQuestionID_\(question.id)"
        if let checkedOptions = UserDefaults.standard.array(forKey: storageID) as? [Int] {
            let set = Set(checkedOptions)
            return set.contains(option.id)
        }
        return false
    }
    
    func getChosenOption(_ question: QuestionData) -> Int {
        let storageID = "checkBoxQuestionID_\(question.id)"
        let chosenOption = UserDefaults.standard.integer(forKey: storageID)
        return chosenOption
    }
    
    func setChosenOption(_ question: QuestionData, option: OptionData) {
        let storageID = "checkBoxQuestionID_\(question.id)"
        UserDefaults.standard.set(option.id, forKey: storageID)
        UserDefaults.standard.synchronize()
    }
}


// FIXME: move to a json file and parse

var questions = Bundle.main.decode([QuestionData].self, from: "Personalization.json")

