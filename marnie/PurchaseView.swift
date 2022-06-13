//
//  PurchaseView.swift
//  marnie
//
//  Created by Daniya on 14/06/2022.
//

import SwiftUI
import DonationKit

struct PurchaseView: UIViewControllerRepresentable {
   
    let language: String
    
    typealias UIViewControllerType = PurchaseController

    func makeUIViewController(context: Context) -> PurchaseController {
        let purchaseIdForHistory = "support"

        let donatedBefore = PurchaseStorage.checkPurchase(purchaseIdForHistory)

        var statementImage: UIImage?
        var successImage: UIImage?

        statementImage = UIImage(named: "giving_with_love")
        successImage = UIImage(named: "heart")

        let statementText: String
        var highlightedText: String?
        let successText: String
        let successButtonTitle: String

        switch (donatedBefore) {
        case true:
            statementText = "SalesPitchReturningCustomer".localized(for: language)
            successText = "ThanksReturningCustomer".localized(for: language)
            successButtonTitle = "Amen".localized(for: language)
        case false:
            statementText = "StatementPitch".localized(for: language)
            highlightedText = "StatementPitchHighlighted".localized(for: language)
            successText = "Thanks".localized(for: language)
            successButtonTitle = "Amen".localized(for: language)
        }

        let purchaseIdentifiers: [String] = [
           "com.marnie.000_99",
           "com.marnie.001_99",
           "com.marnie.004_99",
       ]

        let purchaseConfigStandard = PurchaseConfigurable(
            configID: "",
            title: "Donate".localized(for: language),
            statementImage: statementImage,
            statementLabelText: statementText,
            highlightedLabelText: highlightedText,
            purchaseButtonTitle: "Donate".localized(for: language),
            isSecondaryButtonHidden: true,
            successImage: successImage,
            isSuccessImagePulsating: true,
            successLabelText: successText,
            successButtonTitle: successButtonTitle,
            purchaseFailedText: "PurchaseFailed".localized(for: language),
            tryAgainButtonTitle: "TryAgain".localized(for: language),
            purchaseIdForHistory: purchaseIdForHistory
        )


        let purchaseController = PurchaseBuilder(
            analytics: nil,
            purchaseProductIdentifiers: purchaseIdentifiers,
            config: purchaseConfigStandard
        )
        
        return purchaseController.view as! PurchaseController
    }
    
    func updateUIViewController(_ uiViewController: PurchaseController, context: Context) {
        
    }

}
