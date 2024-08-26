//
//  TestImageFromTheInternet.swift
//  MovieHarmony
//
//  Created by Максим Французов on 12.04.2024.
//

import SwiftUI

struct TestImageFromTheInternet: View {
    var body: some View {
        AsyncImage(url: URL(string: "https://hws.dev/paul.jpg"), scale: 2)
    }
}

#Preview {
    TestImageFromTheInternet()
}
