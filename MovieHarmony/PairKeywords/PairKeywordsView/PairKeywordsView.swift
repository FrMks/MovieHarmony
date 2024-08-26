//
//  PairKeywords.swift
//  MovieHarmony
//
//  Created by Максим Французов on 19.03.2024.
//

import SwiftUI

struct PairKeywordsView: View {
    
    //@ObservedObject var pairKeywordVM = PairKeywordAndQuestionAnswersVM()
    @EnvironmentObject var pairKeywordVM: PairKeywordVM
    @EnvironmentObject var questionAnswersVM: QuestionAnswersVM
    @EnvironmentObject var postersVM: PostersVM
    
    @State var firstImage: String
    @State var secondImage: String
    
    var model: Model
    
    private let keywordNumberFirst = "first"
    private let keywordNumberSecond = "second"
    
    
    
    var body: some View {
        GeometryReader { geometry in
            
            let imageWidth: CGFloat = geometry.size.width * 0.4
            let imageHeight: CGFloat = (imageWidth / 1024) * 1024 // Поддерживает соотношение сторон изображения
            
            
            VStack() {
                Spacer()
                
                //TopBarMenuView(model: model)
                Text("Select a keyword.")
                    .font(.title)
                    .bold()
                
                
                
                HStack {
                    Spacer()
                    Button(action: {
                        pairKeywordVM.selectKeywords(keywordNumberFirstOrSecond: "first")
                        pairKeywordVM.takePairInKeywords()
                    }) {
                        Text(pairKeywordVM.first)
                            .frame(width: imageWidth)
                            .padding(10)
                    }
                    Spacer()
                    Button(action: {
                        pairKeywordVM.selectKeywords(keywordNumberFirstOrSecond: "second")
                        pairKeywordVM.takePairInKeywords()
                    }) {
                        Text(pairKeywordVM.second)
                            .frame(width: imageWidth)
                            .padding(10)
                    }
                    Spacer()
//                    VStack {
//                        HStack {
//                            Spacer()
//                            Button(action: {
//                                pairKeywordVM.selectKeywords(keywordNumberFirstOrSecond: "first")
//                                pairKeywordVM.takePairInKeywords()
//                            }) {
//                                Image(firstImage)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: imageWidth, height: imageHeight)
//                            }
//                            
//                            Spacer()
//                            Button(action: {
//                                pairKeywordVM.selectKeywords(keywordNumberFirstOrSecond: "second")
//                                pairKeywordVM.takePairInKeywords()
//                            }) {
//                                Image(secondImage)
//                                    .resizable()
//                                    .scaledToFit()
//                                    .frame(width: imageWidth, height: imageHeight)
//                            }
//                            Spacer()
//                        }.padding([.trailing, .leading], 10)
//                        HStack {
//                            Spacer()
//                            Text(pairKeywordVM.first)
//                                .frame(width: imageWidth)
//                                .padding(10)
//                            Spacer()
//                            Text(pairKeywordVM.second)
//                                .frame(width: imageWidth)
//                                .padding(10)
//                            Spacer()
//                        }.padding([.trailing, .leading], 10)
//                    }
                }
                
                Spacer()
                
                if pairKeywordVM.selectedKeywords.count >= 10 {
                    Button(action: {
                        //pairKeywordVM.postSelectedKeywords()
                        model.screen = .questionAnswersScreen
                    }) {
                        Text("Moving on to the next phase")
                    }
                }
                
                
            }.padding([.top, .bottom], 10)
            
        }.onAppear {
            pairKeywordVM.getKeywords()
        }
    }
}

struct PairKeywordsView_Previews: PreviewProvider {
    static var previews: some View {
        let pairKeywordVM = PairKeywordVM()
        let questionAnswersVM = QuestionAnswersVM()
        
        return PairKeywordsView(firstImage: "testImageForKeywords1024x1024", secondImage: "testImageForKeywords1024x1024", model: Model())
            .environmentObject(pairKeywordVM)
            .environmentObject(questionAnswersVM)
    }
}
