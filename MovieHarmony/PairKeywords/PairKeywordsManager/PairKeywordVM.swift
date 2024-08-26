//
//  PairKeywordVM.swift
//  MovieHarmony
//
//  Created by Максим Французов on 20.03.2024.
//

import Foundation

class PairKeywordVM: ObservableObject {
    
    @Published var keywords: [Pair] = []
    @Published var first: String = ""
    @Published var second: String = ""

    @Published var selectedKeywords: [String] = []
    
    var currentIndex: Int = 0
    
    
    let apiClient: ApiClient = ApiClientImplementation()
    
    
    func getKeywords() {
        currentIndex = 0
    
        apiClient.getPairsKeywords(completion: { result in
            DispatchQueue.main.async { //переходим на главный поток
                switch result {
                case .success(let keywords):
                    self.keywords = keywords
                    //print("keywords: \(keywords)")
                    print("self.keywords: \(self.keywords)")
                    
                    
                    if let currentPair = keywords.first {
                        self.first = currentPair.first
                        self.second = currentPair.second
                    } else {
                        self.first = ""
                        self.second = ""
                    }
                    
                    
                case .failure:
                    self.keywords = []
                    print("Error and keywords = []")
                }
            }
        })
        
    }
    
    
    func takePairInKeywords() {
        guard currentIndex < keywords.count else {
            print("Мы прошли весь массив")
            return
        }
        
        currentIndex += 1
        
        if(currentIndex == keywords.count) {
            currentIndex = keywords.count - 1
        }
        
        let currentPair = keywords[currentIndex]
        first = currentPair.first
        second = currentPair.second
        
        //currentIndex += 1
    }
    
    func selectKeywords(keywordNumberFirstOrSecond: String) {
        if(selectedKeywords.last == first || selectedKeywords.last == second) {
            print("Мы прошли весь массив, selectKeywords")
            return
        } else {
            if(keywordNumberFirstOrSecond == "first") {
                selectedKeywords.append(first)
                print(first)
            } else if(keywordNumberFirstOrSecond == "second") {
                selectedKeywords.append(second)
                print(second)
            } else {
                print("Проверь что приходит в функцию, это неправильно")
            }
            print(selectedKeywords)
        }
    }
    
    
//    func postSelectedKeywords() {
//        apiClient.postSelectedKeywords(selectedKeywords: selectedKeywords, completion: { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    print("Selected keywords posted successfully")
//                case .failure(let error):
//                    print("Error posting selected keywords: ", error.localizedDescription)
//                }
//            }
//        })
//    }
}
