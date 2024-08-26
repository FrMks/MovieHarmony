//
//  TopbarView.swift
//  MovieHarmony
//
//  Created by Максим Французов on 27.04.2024.
//

import SwiftUI

struct TopBarMenuView: View {
    var model: Model
    var body: some View {
        HStack {
            Menu {
                Button(action: {
                    model.screen = .pairKeywordScreen
                }) {
                    Text("From the beginning")
                }
            } label: {
                Label("Options", systemImage: "line.horizontal.3")
                    .font(.system(size: 20))
            }
            Spacer()
        }.padding(10)
        
    }
}

#Preview {
    TopBarMenuView(model: Model())
}
