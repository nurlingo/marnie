//
//  ViewRouter.swift
//  marnie
//
//  Created by Daniya on 14/06/2022.
//

import SwiftUI

class ViewRouter: ObservableObject {

    @Published var willMoveToDonationScreen = false
    
}


extension View {
    /// Navigate to a new view.
    /// - Parameters:
    ///   - view: View to navigate to.
    ///   - binding: Only navigates when this condition is `true`.
    func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self
            NavigationLink(
                destination: view,
                isActive: binding
            ) {
                EmptyView()
            }
        }
    }
}
