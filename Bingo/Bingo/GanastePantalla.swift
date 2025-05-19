//
//  GanastePantalla.swift
//  Bingo
//
//  Created by alumno on 16/05/25.
//

import SwiftUI

struct GanastePantalla: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("¡Ganaste! 🎉")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.pink)

            Text("¡Felicidades, hiciste bingo!")
                .font(.title2)
                .foregroundColor(.purple)

            Button(action: {
                dismiss() // Esto te regresa a la pantalla anterior dentro del NavigationStack
            }) {
                Text("Volver al Inicio")
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}

#Preview {
    GanastePantalla()
}

