//
//  QuestionAnswersView.swift
//  MovieHarmony
//
//  Created by Максим Французов on 29.03.2024.
//

import SwiftUI

struct QuestionAnswersView: View {
    
    @EnvironmentObject var pairKeywordVM: PairKeywordVM
    @EnvironmentObject var questionAnswersVM: QuestionAnswersVM
    @EnvironmentObject var postersVM: PostersVM
    
    private let answerNumberFirst = "first"
    private let answerNumberSecond = "second"
    private let answerNumberThird = "third"
    private let answerNumberFourth = "fourth"
    
    var model: Model
    
    var body: some View {
        GeometryReader { geometry in
            
            let frameWidthForText: CGFloat = geometry.size.width * 0.4
            
            if questionAnswersVM.isLoading {
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        ProgressView()
                            .padding()
                        Spacer()
                    }
                    Spacer()
                }
            } else {
                VStack {
                    //TopBarMenuView(model: model)
                    Spacer()
                    Text(questionAnswersVM.question)
                        .font(.title)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .padding(10)
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                questionAnswersVM.selectAnswers(answerNumber: answerNumberFirst)
                                questionAnswersVM.takeQA()
                            }) {
                                Text(questionAnswersVM.firstA)
                                    .frame(width: frameWidthForText)
                                    .padding(10)
                            }
                            Spacer()
                            Button(action: {
                                questionAnswersVM.selectAnswers(answerNumber: answerNumberSecond)
                                questionAnswersVM.takeQA()
                            }) {
                                Text(questionAnswersVM.secondA)
                                    .frame(width: frameWidthForText)
                                    .padding(10)
                            }
                            Spacer()
                        }.padding([.trailing, .leading], 10)
                        HStack {
                            Spacer()
                            Button(action: {
                                questionAnswersVM.selectAnswers(answerNumber: answerNumberThird)
                                questionAnswersVM.takeQA()
                            }) {
                                Text(questionAnswersVM.thirdA)
                                    .frame(width: frameWidthForText)
                                    .padding(10)
                            }
                            Spacer()
                            Button(action: {
                                questionAnswersVM.selectAnswers(answerNumber: answerNumberFourth)
                                questionAnswersVM.takeQA()
                            }) {
                                Text(questionAnswersVM.fourthA)
                                    .frame(width: frameWidthForText)
                                    .padding(10)
                            }
                            Spacer()
                        }.padding([.trailing, .leading], 10)
                        
                    }
                    Spacer()
                    if questionAnswersVM.selectedA.count >= 10 {
                        Button(action: {
                            questionAnswersVM.appendKeywordAndAnswerToList(selectedKeyword: pairKeywordVM.selectedKeywords)
                            model.screen = .postersScreen
                        }) {
                            Text("Moving on to the next phase")
                        }
                    }
                }
            }
            
            
        }.onAppear {
            questionAnswersVM.isLoading = true
            questionAnswersVM.getQuestionAnswers(selectedKeyword: pairKeywordVM.selectedKeywords)
        }
        
    }
}

struct QuestionAnswersView_Previews: PreviewProvider {
    static var previews: some View {
        let pairKeywordVM = PairKeywordVM()
        let questionAnswersVM = QuestionAnswersVM()
        
        return QuestionAnswersView(model: Model())
            .environmentObject(pairKeywordVM)
            .environmentObject(questionAnswersVM)
    }
}
