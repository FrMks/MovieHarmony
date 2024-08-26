//
//  PairKeywords.swift
//  MovieHarmony
//
//  Created by Максим Французов on 19.03.2024.
//

import Foundation


struct PairsKeywordsResponse: Decodable {
    let data: [Pair]
}

struct Pair: Decodable {
    let first: String
    let second: String
}

