//
//  Model.swift
//  MovieHarmony
//
//  Created by Максим Французов on 29.03.2024.
//

import Foundation

class Model: ObservableObject {
    enum Screen {
        case pairKeywordScreen
        case questionAnswersScreen
        case postersScreen
        case testImageFromTheInternet
    }
    @Published var screen = Screen.pairKeywordScreen
    //@Published var screen = Screen.postersScreen
    //@Published var screen = Screen.testImageFromTheInternet
}
