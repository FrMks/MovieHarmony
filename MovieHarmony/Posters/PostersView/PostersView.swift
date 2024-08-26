//
//  PostersView.swift
//  MovieHarmony
//
//  Created by Максим Французов on 03.04.2024.
//

import SwiftUI

struct PostersView: View {
    
    @EnvironmentObject var questionAnswersVM: QuestionAnswersVM
    @EnvironmentObject var postersVM: PostersVM
    
    //var postersVM = PostersVM()
    @GestureState private var dragState = DragState.inactive //состояние для отслеживания жестов перетаскивания
    
    private let dragThreshold: CGFloat = 80.0 //порог перетаскивания для реагирования на жест
    
    @State private var removalTransition = AnyTransition.trailingBottom //анимация удаления карточки
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                //TopBarMenu()
                Spacer()
                if postersVM.isLoading {
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
                    if postersVM.likedFilms.count + postersVM.dislikedFilms.count == postersVM.filmsWithSimilarity.count {
                        List(postersVM.likedFilmDetails, id: \.film.id) { filmSimResult in
                            VStack(alignment: .leading) {
                                HStack {
                                    Text(filmSimResult.film.name)
                                    Text("Similarity: \(filmSimResult.similarity, specifier: "%.2f")")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    } else {
                        ZStack {
                            ForEach(postersVM.cardViews) { cardView in
                                cardView //отображаем карточку с постером
                                //.zIndex(self.postersVM.isTopCard(cardView: cardView) ? 1 : 0) //если карточка верхняя, ее индекс будет 1, что позволит отобразить ее поверх других элементов. В противном случае, индекс будет 0, и карточка будет находиться под другими элементами
                                    .zIndex(self.postersVM.isTopCard(cardView: cardView) ? 1 : (postersVM.isNextCard(cardView: cardView) ? 0 : -1))
                                
                                    .overlay( //добавляем картинки лайк и дизлайк поверх карточки
                                        ZStack {
                                            Image(systemName: "x.circle")
                                                .foregroundColor(.red)
                                                .font(.system(size: 100))
                                                .opacity(self.dragState.translation.width < -self.dragThreshold && self.postersVM.isTopCard(cardView: cardView) ? 1.0 : 0)
                                            Image(systemName: "heart.circle")
                                                .foregroundColor(.green)
                                                .font(.system(size: 100))
                                                .opacity(self.dragState.translation.width > self.dragThreshold && self.postersVM.isTopCard(cardView: cardView) ? 1.0 : 0)
                                        }
                                    )
                                
                                    .offset(x: self.postersVM.isTopCard(cardView: cardView) ? self.dragState.translation.width : 0,
                                            y: self.postersVM.isTopCard(cardView: cardView) ? self.dragState.translation.height : 0) //если карточка верхняя, мы применяем смещение, определенное жестом, иначе карточка остается на месте
                                
                                    .scaleEffect(self.dragState.isDragging && self.postersVM.isTopCard(cardView: cardView) ? 0.95 : 1.0) //мы уменьшаем масштаб карточки на 5% во время перетаскивания, чтобы создать эффект меньшего размера при активном перетаскивании
                                
                                    .rotationEffect(Angle(degrees: self.postersVM.isTopCard(cardView: cardView) ? Double(self.dragState.translation.width / 10) : 0)) //вращаем карточку в соответствии с горизонтальным смещением, создавая визуальный эффект вращения в зависимости от направления перетаскивания
                                
                                    .animation(.interpolatingSpring(stiffness: 180, damping: 100)) //метод применяет анимацию к изменениям, происходящим с карточкой. Мы используем анимацию пружинного типа, чтобы сделать движение более естественным и плавным
                                
                                    .transition(self.removalTransition) //метод применяет анимацию перехода при удалении карточки
                                
                                    .gesture(LongPressGesture(minimumDuration: 0.01) //жест удержания к карточке. Минимальная продолжительность удержания установлена на 0.01 секунды
                                        .sequenced(before: DragGesture()) //добавляем последовательность жестов: удержание и затем перетаскивание. Пользователь должен сначала удержать карточку, а затем, не отпуская ее, начинать перетаскивание
                                        .updating(self.$dragState, body: { (value, state, transaction) in //используем метод, чтобы обновлять состояние карточки в соответствии с действиями пользователя. Проверяем состояние value жеста и обновляем $dragState
                                            switch value { //value представляет текущее состояние жеста
                                            case .first(true): //проверяем первый кейс value, которые представляет собой начало удержания карточки, если удержание началось, то .pressing
                                                state = .pressing
                                            case .second(true, let drag): //перетасиквание карточки. Если карточка перетаскивается и имеет значение drag, представляющее данные о перетаскивании, мы устанавливаем состояние dragging для переменной state
                                                state = .dragging(translation: drag?.translation ?? .zero)
                                            default:
                                                break
                                            }
                                        })
                                            .onChanged({ (value) in //замыкание вызывается при изменении состояния жеста
                                                guard case .second(true, let drag?) = value else { //проверяем, что состояние соответствует перетаскиванию и извлекаем данные о смещении из значения жеста
                                                    return
                                                }
                                                if drag.translation.width < -self.dragThreshold { //если карточка смещена влево
                                                    self.removalTransition = .leadingBottom //применяем анимацию удаления влево
                                                }
                                                
                                                if drag.translation.width > self.dragThreshold { //если карточка смещена вправо
                                                    self.removalTransition = .trailingBottom //применяем анимацию удаления вправо
                                                }
                                            })
                                                .onEnded({ (value) in // вызываем по окончании жеста
                                                    guard case .second(true, let drag?) = value else {
                                                        return
                                                    }
                                                    if drag.translation.width < -dragThreshold {
                                                        postersVM.moveCard(liked: false)
                                                    } else if drag.translation.width > dragThreshold {
                                                        postersVM.moveCard(liked: true)
                                                    }
                                                    //                                            if drag.translation.width < -self.dragThreshold || drag.translation.width > self.dragThreshold { //достигла ли карточка порогового смещения влево или вправо
                                                    //                                                self.postersVM.moveCard() //перемещаем карточку в соответствии с жестом
                                                    //                                            }
                                                })
                                    )
                            }
                        }
                    }
                }
                
                
                
                Spacer()
                
                //                BottomBarMenu()
                //                    .opacity(dragState.isDragging ? 0.0 : 1.0) //скрываем нижнее меню во время перетаскивания карточки
                //                    .animation(.default)
            }
        }.onAppear {
            if(questionAnswersVM.selectedKeywordsWithAnswersString.isEmpty) {
                print("selectedKeywordsWithAnswersString = []")
            } else {
                postersVM.isLoading = true
                postersVM.getFilmWithSimilarity(selectedKeywordWithAnswer: questionAnswersVM.selectedKeywordsWithAnswersString)
            }
            
        }
    }
}

extension AnyTransition {
    static var trailingBottom: AnyTransition { //анимация удаления карточки вправо и вниз
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .trailing).combined(with: .move(edge: .bottom)))
    }
    static var leadingBottom: AnyTransition { //анимация удаления карточки влево и вниз
        AnyTransition.asymmetric(insertion: .identity, removal: AnyTransition.move(edge: .leading).combined(with: .move(edge: .bottom)))
    }
}


#Preview {
    PostersView()
}

