//
//  FilmSimilarityResult.swift
//  MovieHarmony
//
//  Created by Максим Французов on 09.04.2024.
//

import Foundation

struct FilmSimilarityResultResponse: Decodable {
    let data: [FilmSimilarityResult]
}

struct FilmSimilarityResult: Decodable {
    let film: TMDBFilm
    let similarity: Double
    let url: String
}

struct TMDBFilm: Decodable {
    let id: Int
    let releaseYear: String
    let name: String
    let tagline: String
    let genre: [String]
    let keyWords: [String]
    let overview: String
}
