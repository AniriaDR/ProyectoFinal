//
//  InicioPantalla.swift
//  Bingo
//
//  Created by alumno on 16/05/25.
//

import SwiftUI

struct InicioPantalla: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 30) {
                Text("BINGO")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)

                Image(systemName: "sparkles")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.pink)

                NavigationLink(destination: GameView()) {
                    Text("¡JUGAR!")
                        .font(.title2)
                        .padding()
                        .frame(width: 200)
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(15)
                        .shadow(radius: 5)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(LinearGradient(gradient: Gradient(colors: [.white, .pink.opacity(0.3)]), startPoint: .top, endPoint: .bottom))
        }
    }
}



#Preview {
    InicioPantalla()
}
