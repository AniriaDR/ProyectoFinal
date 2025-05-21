//
//  PausaPantalla.swift
//  Bingo
//
//  Created by alumno on 19/05/25.
//
import SwiftUI

struct PausaPantalla: View {
    let volverJuego: () -> Void
    let volverInicio: () -> Void
    
    var body: some View {
        VStack(spacing: 30) {
            Text("Pausa")
                .font(.system(size: 60, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            Text("Tómate un descanso")
                .font(.title3)
                .foregroundColor(.gray.opacity(0.8))
                .multilineTextAlignment(.center)
            
            
            Button(action: {
                volverJuego()
            }) {
                Text("Volver al juego")
                    .font(.title3.bold())
                    .padding()
                    .frame(width: 250)
                    .background(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(color: .pink.opacity(0.3), radius: 10, x: 0, y: 5)
            }
            
            Button(action: {
                volverInicio()
            }) {
                Text("Volver al inicio")
                    .font(.title3.bold())
                    .padding()
                    .frame(width: 250)
                    .background(Color.white)
                    .foregroundColor(.pink)
                    .overlay(
                        Capsule().stroke(Color.pink, lineWidth: 2)
                    )
                    .clipShape(Capsule())
                    .shadow(color: .gray.opacity(0.1), radius: 5, x: 0, y: 3)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.white, .pink.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    PausaPantalla(volverJuego: {}, volverInicio: {})
}

