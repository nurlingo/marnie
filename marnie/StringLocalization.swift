//
//  StringLocalization.swift
//  marnie
//
//  Created by Daniya on 14/06/2022.
//

import Foundation

extension String {
    func localized(for locale: String? = nil) -> String {
        
        let en = [
            // display name
            "CFBundleDisplayName" : "Marnie",
            "english": "English",
            "russian": "Русский",
            "extra" : "Extras",
            "audios" : "Audios",
            "learn" : "Learn",
            "listen" : "Listen",
            "articles" : "Articles",
            "shareApp" : "Share the App",
            "messageToShare" : "Learn to read: ",
            "salam": "As-salamu 3alaikum!",
            "settings": "Settings",
            "more": "More",
            "settingsAndMore": "Settings & More",
            "chooseLanguage" : "App language",
            "chooseGender" : "Gender",
            "male" : "Men",
            "female" : "Women",
            "choose" : "Choose",
            "repeat" : "Repeat",
            "show" : "Show",
            "hide" : "Hide",
            "basics" : "Basics",
            "details" : "Details",
            "appUrl": "https://apple.co/39pI1kl",
            
            "save": "Save",
            "continue" : "Continue",
            "true" : "True",
            "false": "False",
            "skip" : "Skip",
            "quiz" : "Quiz",
            "hint" : "Hint",
            "check" : "Check",
            "typeAnswer" : "Type your answer here",
            "result" : "Acceptable answers:",
            "tapToAdd"  : "Tap phrases to add them here",
            "useAllBlocks" : "Use all the blocks",
            "awardTitle" :"Your progress",
            "totalQuestions" : "Total questions",
            "userPoints" :  "Answered correctly",
            "bestPoints" : "Best result so far",
            "tapToContinue" : "Tap to continue",
            "errorOnLine" : "Error on line",
            "chooseALine" : "Choose a line",
            
            "allowNotifications": "Allow notifications?",
            "justifyNotifications": "We'll ocasionally send you reminders to pray, and also notify you about new content additions.",
            "enableNotifications": "Enable notifications to get ocassional prayer reminders",
            "dismiss": "Dismiss",
            "enable": "Enable",
            "yesPlease": "Yes, please",
            "notificationStandardTitle": "Learn to read",
            "notificationStandardBody":"",
            
            "Support": "Support Marnie App",
            "BonusItemTitle": "Support the app and get a bonus",
            "StatementPitch": "Our mission is to help Muslims succeed.\n\nPlease support us, and let's try to make it to Jannah together!",
            "SalesPitchReturningCustomer": "You've donated already,\nma shaa Allah!\n\nIf you want to give more,\nwe'll very much appreciate it.",
            "Thanks": "Thank you for donating!\n\nMay Allah reward you well for your generosity.",
            "ThanksBonus": "Thank you for donating!\n\nAs a gift, we present you with Dua Istikhara, which can be recited when making a decision.",
            "ThanksReturningCustomer": "Jazakumullahu khairan!\n\nMay Allah reward you for your continious support.",
            "Proceed": "Go to bonus",
            "PurchaseFailed": "Purchase failed, please try again",
            "TryAgain": "Try again",
            "Continue": "Continue",
            "Amen": "Amen!",
            "Donate": "Donate",
            "Bonus": "Bonus",
            "Exit": "Exit",
            "Cancel": "Cancel",
            "AreYouSure": "Are you sure?",
        ]
        
        let ru = [
            // display name
            "CFBundleDisplayName" : "Марни",
            "english": "English",
            "russian": "Русский",
            "extra" : "Дополнительно",
            "audios" : "Аудио",
            "learn" : "Обучение",
            "listen" : "Слушайте",
            "articles" : "Для прочтения",
            "shareApp" : "Поделиться аппом",
            "messageToShare" : "Научитесь читать. Скачайте на смартфон:\n",
            "salam": "Ассаляму аляйкум!",
            "settings": "Настройки",
            "more": "Разное",
            "settingsAndMore": "Настройки и разное",
            "chooseLanguage" : "Язык приложения",
            "chooseGender" : "Выберите пол",
            "male" : "Мужчина",
            "female" : "Женщина",
            "choose" : "Выберите",
            "repeat" : "Повторить",
            "show" : "Показать",
            "hide" : "Скрыть",
            "basics" : "Кратко",
            "details" : "Подробно",
            "appUrl": "https://apple.co/39pI1kl",
            
            "save": "Сохранить",
            "continue" : "Продолжить",
            "true" : "Да",
            "false": "Нет",
            "skip" : "Пропустить",
            "quiz" : "Тест",
            "hint" : "Подсказка",
            "check" : "Проверить",
            "typeAnswer" : "Напечатайте здесь",
            "result" : "Возможные ответы:",
            "tapToAdd"  : "Нажимайте на блоки чтобы добавить их",
            "useAllBlocks" : "Используйте все блоки",
            "awardTitle" :"Ваш прогресс",
            "totalQuestions" : "Всего вопросов",
            "userPoints" :  "Правильных ответов",
            "bestPoints" : "Лучший результат",
            "tapToContinue" : "Нажмите чтобы продолжить",
            "errorOnLine" : "Ошибка на строке",
            "chooseALine" : "Выберите строку",

            "allowNotifications": "Разрешить уведомления?",
            "justifyNotifications": "Вы будете время от времени получать напоминания о намазе.",
            "enableNotifications": "Включите уведомления, чтобы получать напоминания о намазе",
            "dismiss": "Скрыть",
            "enable": "Включить",
            "yesPlease": "Разрешить",
            "notificationStandardTitle": "Давайте учиться читать!",
            "notificationStandardBody":"",
            
            "Support": "Поддержите Марни Апп",
            "BonusItemTitle": "Поддержите наш апп и получите бонус!",
            "StatementPitch": "Наша цель - помогать мусульманам быть успешными.\nПоддержите нас!",
            "SalesPitchReturningCustomer": "Машаа Аллаh!\nСпасибо, что хотите поддержать нас еще раз!",
            "Thanks": "ДжазакумуЛлаhу хайран!\n\nПусть Всевышний наградит вас за вашу щедрость.",
            "ThanksBonus": "Спасибо за вашу поддержку!\n\nВ подарок вы получаете аудио Дуа Истихара, которое можно произносить при принятии решений.",
            "ThanksReturningCustomer": "Очень ценим, что вы поддержали нас уже несколько раз. Спасибо!",
            "Proceed": "Дальше",
            "PurchaseFailed": "Оплата не прошла, попробуйте еще раз",
            "TryAgain": "Попробовать",
            "Continue": "Продолжить",
            "Amen": "Амин!",
            "Donate": "Поддержать",
            "Bonus": "Бонус",
            "Exit": "Выйти",
            "Cancel": "Отмена",
            "AreYouSure": "Вы уверены?",
        ]
        
        guard let locale = locale else {
            return en[self] ?? self
        }
        
        if locale == "ru" {
            return ru[self] ?? self
        } else {
            return en[self] ?? self
        }
    }
}
