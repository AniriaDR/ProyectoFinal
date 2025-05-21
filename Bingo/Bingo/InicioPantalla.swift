//
//  InicioPantalla.swift
//  Bingo
//
//  Created by alumno on 16/05/25.
//

import SwiftUI

struct InicioPantalla: View {
    @Binding var pantallaActual: PantallaActual
    
    var body: some View {
        VStack(spacing: 30) {
            Text("BINGO")
                .font(.system(size: 60, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .purple],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
            
            Image(systemName: "dice.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .foregroundStyle(
                    LinearGradient(
                        colors: [.pink, .purple],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
            
            Button(action: {
                print("DEBUG - Botón JUGAR presionado")
                withAnimation {
                    pantallaActual = .juego
                }
            }) {
                Text("¡JUGAR!")
                    .font(.title2.bold())
                    .padding()
                    .frame(width: 200)
                    .background(
                        LinearGradient(
                            colors: [.pink, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(color: .pink.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            .buttonStyle(ScaleButtonStyle())
        }
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

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

#Preview {
    InicioPantalla(pantallaActual: .constant(.inicio))
}

