//
//  MovieHarmonyApp.swift
//  MovieHarmony
//
//  Created by Максим Французов on 05.02.2024.
//

import SwiftUI

@main
struct MovieHarmonyApp: App {
    
    @StateObject var pairKeywordVM = PairKeywordVM()
    @StateObject var questionAnswersVM = QuestionAnswersVM()
    @StateObject var postersVM = PostersVM()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(pairKeywordVM)
                .environmentObject(questionAnswersVM)
                .environmentObject(postersVM)
        }
    }
}
