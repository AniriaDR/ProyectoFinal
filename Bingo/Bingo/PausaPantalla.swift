//
//  PausaPantalla.swift
//  Bingo
//
//  Created by alumno on 19/05/25.
//
import SwiftUI

struct PausaPantalla: View {
    @Environment(\.dismiss) var dismiss

    var body: some View {
        ZStack {
            Color.pink.opacity(0.1).ignoresSafeArea()

            VStack(spacing: 30) {
                Text("Pausa")
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(.pink)
                
                Text("Tómate un descanso")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.pink.opacity(0.8))
                
                Button(action: {
                    dismiss() // Cierra la pantalla de pausa
                }) {
                    Text("Volver al juego")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink.opacity(0.4))
                        .foregroundColor(.pink)
                        .cornerRadius(12)
                }
                
                NavigationLink(destination: InicioPantalla()) {
                    Text("Volver al inicio")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink.opacity(0.4))
                        .foregroundColor(.pink)
                        .cornerRadius(12)
                }

                .padding()
            }
        }
    }
}

#Preview {
    PausaPantalla()
}
