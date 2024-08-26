//
//  QuestionAnswersVM.swift
//  MovieHarmony
//
//  Created by Максим Французов on 29.03.2024.
//

import Foundation

class QuestionAnswersVM: ObservableObject {
    
    @Published var questionAnswers: [QuestionAnswers] = []
    @Published var question: String = ""
    @Published var firstA: String = ""
    @Published var secondA: String = ""
    @Published var thirdA: String = ""
    @Published var fourthA: String = ""
    @Published var isLoading: Bool = false
    
    
    var selectedA: [String] = []
    var currentIndex: Int = 0
    
    var selectedKeywordWithAnswer: [KeywordWithAnswer] = []
    @Published var selectedKeywordsWithAnswersString: [String] = []
    
    let apiClient: ApiClient = ApiClientImplementation()
    
    func getQuestionAnswers(selectedKeyword: [String]) {
        apiClient.postSelectedKeywords(selectedKeywords: selectedKeyword, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let questionAnswers):
                    self.questionAnswers = questionAnswers
                    print("self.questionAnswers \(self.questionAnswers)")
                    
                    if let currentQA = questionAnswers.first {
                        self.question = currentQA.question
                        self.firstA = currentQA.answers[0]
                        self.secondA = currentQA.answers[1]
                        self.thirdA = currentQA.answers[2]
                        self.fourthA = currentQA.answers[3]
                        self.isLoading = false
                    } else {
                        self.question = "Question"
                        self.firstA = "firstA"
                        self.secondA = "secondA"
                        self.thirdA = "thirdA"
                        self.fourthA = "fourthA"
                    }
                    
                    
                    
                case .failure:
                    self.questionAnswers = []
                    print("Error and questionAnswers = []")
                }
            }
        })
    }
    
    
    func takeQA() {
        guard currentIndex < questionAnswers.count else {
            print("QA: Мы прошли весь массив")
            return
        }
        
        currentIndex += 1
        
        if(currentIndex == questionAnswers.count) {
            currentIndex = questionAnswers.count - 1
        }
        
        let currentQA = questionAnswers[currentIndex]
        question = currentQA.question
        firstA = currentQA.answers[0]
        secondA = currentQA.answers[1]
        thirdA = currentQA.answers[2]
        fourthA = currentQA.answers[3]
    }
    
    func selectAnswers(answerNumber: String) {
        if(selectedA.last == firstA || selectedA.last == secondA || selectedA.last == thirdA || selectedA.last == fourthA) {
            print("QA: Мы прошли весь массив, selectedA")
            return
        } else {
            if(answerNumber == "first") {
                selectedA.append(firstA)
            } else if(answerNumber == "second") {
                selectedA.append(secondA)
            } else if(answerNumber == "third") {
                selectedA.append(thirdA)
            } else if(answerNumber == "fourth") {
                selectedA.append(fourthA)
            } else {
                print("QA: Проверь что происходит в функции, это неправильно")
            }
        }
        print(selectedA)
    }
    
    
//    func appendKeywordAndAnswerToList(selectedKeyword: [String]) {
//        for i in 0..<10 {
//            selectedKeywordWithAnswer.append(KeywordWithAnswer(keyword: selectedKeyword[i], answer: selectedA[i]))
//        }
//    }
    
    func appendKeywordAndAnswerToList(selectedKeyword: [String]) {
        for i in 0..<10 {
            let keywordWithAnswerString = "\(selectedKeyword[i]): \(selectedA[i])"
            selectedKeywordsWithAnswersString.append(keywordWithAnswerString)
            
            selectedKeywordWithAnswer.append(KeywordWithAnswer(keyword: selectedKeyword[i], answer: selectedA[i]))
        }
    }
}


