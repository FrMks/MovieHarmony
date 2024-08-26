//
//  QuestionAnswers.swift
//  MovieHarmony
//
//  Created by Максим Французов on 29.03.2024.
//

import Foundation


struct QuestionAnswersResponse: Decodable {
    let data: [QuestionAnswers]
}

struct QuestionAnswers: Decodable {
    let question: String
    let answers: [String]
}
