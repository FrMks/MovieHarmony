//
//  ContentView.swift
//  MovieHarmony
//
//  Created by Максим Французов on 05.02.2024.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var model = Model()
    @StateObject var pairKeywordVM = PairKeywordVM()
    @StateObject var questionAnswersVM = QuestionAnswersVM()
    @StateObject var postersVM = PostersVM()
    
    var body: some View {
        VStack {
            switch model.screen {
            case .pairKeywordScreen:
                PairKeywordsView(firstImage: "testImageForKeywords1024x1024", secondImage: "testImageForKeywords1024x1024", model: self.model)
                    .environmentObject(pairKeywordVM)
                    .environmentObject(questionAnswersVM)
                    .environmentObject(postersVM)
            case .questionAnswersScreen:
                QuestionAnswersView(model: self.model)
                    .environmentObject(pairKeywordVM)
                    .environmentObject(questionAnswersVM)
                    .environmentObject(postersVM)
            case .postersScreen:
                PostersView()
                    .environmentObject(pairKeywordVM)
                    .environmentObject(questionAnswersVM)
                    .environmentObject(postersVM)
            case .testImageFromTheInternet:
                TestImageFromTheInternet()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



