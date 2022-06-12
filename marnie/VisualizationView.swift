//
//  VisualizationView.swift
//  marnie
//
//  Created by Daniya on 12/06/2022.
//

import SwiftUI

struct VisualizationView: View {
    
    @StateObject var vm: VisualizationViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack {
                ForEach(vm.imageUrls, id: \.self) { imageUrl in
                    AsyncImage(url: URL(string: imageUrl)) { image in
                        image.resizable()
                    } placeholder: {
                        Color.gray
                    }
                    .frame(width: 250, height: 250)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
        }
    }
}


class VisualizationViewModel: NSObject, ObservableObject {

    @Published var phrase: String = " "
    @Published var imageUrls = [String]()
    let ls: VocabularyService
    
    init(ls: VocabularyService, ss: SpeechService) {
        self.ls = ls
    }
    
    var words = [String]()
    
    func startNewGame() {
        words = ls.words
    }
    
    func goToNextPhrase() {
        
        if words.count > 0 {
            phrase = words.removeLast()
            let querry = phrase + " " + ls.topic.id
            VisualizerHelper.shared.requestImagesFromGoogle(querry: querry, handler: self.handleImages)
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 10.0) {
                fatalError()
            }
        }
        
        
    }
    
    func handleImages(response: GoogleResponse?, error: GenericError?) {
        
        if let error = error {
            print(#function, "error getting the imageItems remotly -> \(error.type) \(error.description)")
            return
        }
        
        guard let response = response else {
            print(#function, "imageItems are nil")
            return
        }
        
        DispatchQueue.main.async {
            self.imageUrls = response.items.map{ $0.link }.shuffled()
        }
        
    }
    
}
