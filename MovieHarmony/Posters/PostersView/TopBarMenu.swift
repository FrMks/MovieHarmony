//
//  TopBarMenu.swift
//  MovieHarmony
//
//  Created by Максим Французов on 05.04.2024.
//

import SwiftUI

struct TopBarMenu: View {
    var body: some View {
        HStack {
            Image(systemName: "line.horizontal.3")
                .font(.system(size: 30))
            Spacer()
//            Image(systemName: "flame.fill")
//                .font(.system(size: 35))
//                .foregroundColor(.red)
//            Spacer()
//            Rectangle()
//                .foregroundColor(.clear)
//                .frame(width: 30, height: 30)
//            Image(systemName: "bubble.left.and.bubble.right")
//                .font(.system(size: 30))
        }
        .padding()
    }
}

#Preview {
    TopBarMenu()
}
