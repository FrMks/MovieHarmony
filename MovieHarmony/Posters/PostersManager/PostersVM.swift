//
//  PostersVM.swift
//  MovieHarmony
//
//  Created by Максим Французов on 03.04.2024.
//

import Foundation

class PostersVM: ObservableObject {
    @Published var name: String = ""
    @Published var similarity: Double = 0.0
    @Published var url: String = ""
    
    let apiClient: ApiClient = ApiClientImplementation()
    @Published var cardViews: [CardView] = []
    @Published var topCardIndex: Int = 0
    @Published var filmsWithSimilarity: [FilmSimilarityResult] = []
    
    @Published var likedFilms: [TMDBFilm] = []
    @Published var dislikedFilms: [TMDBFilm] = []
    @Published var likedFilmDetails: [FilmSimilarityResult] = []
    @Published var isLoading: Bool = false

    func getFilmWithSimilarity(selectedKeywordWithAnswer: [String]) {
        apiClient.postPostersSendKeywordsWithAnswers(selectedKeywordsWithAnswers: selectedKeywordWithAnswer, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let filmWithSim):
                    self.filmsWithSimilarity = filmWithSim
                    print("self.filmsWithSimilarity \(self.filmsWithSimilarity)")
                    
                    self.initializeCardViews()
                    
                    if let currentFS = filmWithSim.first {
                        self.name = currentFS.film.name
                        self.similarity = currentFS.similarity
                        self.url = currentFS.url
                        self.isLoading = false
                    } else {
                        self.name = "NAME"
                        self.similarity = 0.0
                        self.url = ""
                    }
                    
                case .failure(let error):
                    print("Error in func getFilmWithSimilarity: \(error)")
                    self.filmsWithSimilarity = []
                    self.cardViews = []  // Clear card views on failure
                    print("Error and filmsWithSimilarity = []")
                }
            }
        })
    }

    func initializeCardViews() {
        self.cardViews = self.filmsWithSimilarity.map { filmSimResult in
            CardView(image: filmSimResult.url)
        }
        self.topCardIndex = 0
        //добавил
        //self.allFilmsReviewed = false
    }

    func moveCard(liked: Bool) {
        if topCardIndex < filmsWithSimilarity.count {
            let film = filmsWithSimilarity[topCardIndex]
            if liked {
                likedFilms.append(film.film)
                print("likedFilms: \(likedFilms)")
                likedFilmDetails.append(film)
            } else {
                dislikedFilms.append(film.film)
                print("dislikedFilms: \(dislikedFilms)")
            }
        }
        
        if topCardIndex < cardViews.count - 1 {
            topCardIndex += 1
        } else {
            topCardIndex = 0
        }
    }

    func isTopCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == topCardIndex
    }
    
    func isNextCard(cardView: CardView) -> Bool {
        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
            return false
        }
        return index == topCardIndex + 1
    }
    
    func findFilmSimilarityResult(for film: TMDBFilm) -> FilmSimilarityResult? {
        return filmsWithSimilarity.first { $0.film.id == film.id }
    }
}

    
    //    private func updateCardViews() {
    //        cardViews = []
    //        lastIndex = 0
    //        for index in 0..<min(2, filmsWithSimilarity.count) {
    //            cardViews.append(CardView(image: filmsWithSimilarity[index].url))
    //        }
    //        print("updateCardViews: Initialized cardViews with the first two cards")
    //        print("Current cardViews: \(cardViews.map { $0.image })")
    //    }
    //
    //    func isTopCard(cardView: CardView) -> Bool {
    //        guard let index = cardViews.firstIndex(where: { $0.id == cardView.id }) else {
    //            return false
    //        }
    //        return index == 0
    //    }
    //
    //    func moveCard() {
    //        guard !cardViews.isEmpty else { return }
    //
    //        cardViews.removeFirst()
    //
    //        lastIndex += 1
    //        let newCardIndex = lastIndex % filmsWithSimilarity.count
    //        let newCardView = CardView(image: filmsWithSimilarity[newCardIndex].url)
    //
    //        cardViews.append(newCardView)
    //
    //        print("moveCard: Moved to the next card, lastIndex is now \(lastIndex)")
    //        print("moveCard: Added new card with URL: \(filmsWithSimilarity[newCardIndex].url)")
    //        print("Current cardViews: \(cardViews.map { $0.image })")
    //    }


