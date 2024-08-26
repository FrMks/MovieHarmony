//
//  CardView.swift
//  MovieHarmony
//
//  Created by Максим Французов on 03.04.2024.
//

import SwiftUI

struct CardView: View, Identifiable {
    
    //let title: String
    let image: String
    let id = UUID()
    
    var body: some View {
        AsyncImage(url: URL(string: image)) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(minWidth: 0.8, maxWidth: .infinity)
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0.8, maxWidth: .infinity)
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
            case .failure:
                Image(systemName: "photo")
                    .resizable()
                    .scaledToFit()
                    .frame(minWidth: 0.8, maxWidth: .infinity)
                    .cornerRadius(10)
                    .padding(.horizontal, 15)
            @unknown default:
                EmptyView()
            }
        }
    }
}

#Preview {
    CardView(image: "testImageForPosters1024x1024")
    //CardView(image: "")
}
