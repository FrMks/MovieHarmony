//
//  BottomBarMenu.swift
//  MovieHarmony
//
//  Created by Максим Французов on 05.04.2024.
//

import SwiftUI

struct BottomBarMenu: View {
    var body: some View {
        HStack {
            
            Image(systemName: "xmark")
                .font(.system(size: 40))
                .foregroundColor(.red)
            Button(action: {
                //отправить результаты на сервер после того, как пользователь прошелся по всем фильмам
            }) {
                Text("I liked these posters")
                    .font(.system(.headline, design: .rounded))
                    .bold()
                    .foregroundColor(.black)
                    .padding(.horizontal, 35)
                    .padding(.vertical, 15)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                    RoundedRectangle(cornerRadius: 30)
                        .stroke(Color.black, lineWidth: 2)
                    )
            }
            .padding(.horizontal, 20)
            
            Image(systemName: "heart.fill")
                .font(.system(size: 40))
                .foregroundColor(.green)
            
        }
    }
}

#Preview {
    BottomBarMenu()
}
