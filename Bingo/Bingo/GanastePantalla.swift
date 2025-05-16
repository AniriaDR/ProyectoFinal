//
//  GanastePantalla.swift
//  Bingo
//
//  Created by alumno on 16/05/25.
//

import SwiftUI

struct GanastePantalla: View {
    var body: some View {
        VStack(spacing: 30) {
            Text("¡GANASTE!")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.pink)

            Image(systemName: "crown.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundColor(.yellow)

            NavigationLink(destination: InicioPantalla()) {
                Text("Volver al inicio")
                    .font(.title3)
                    .padding()
                    .frame(width: 200)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(15)
                    .shadow(radius: 5)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [.white, .pink.opacity(0.2)]), startPoint: .top, endPoint: .bottom))
    }
}



#Preview {
    GanastePantalla()
}
