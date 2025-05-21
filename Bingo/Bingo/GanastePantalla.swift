//
//  GanastePantalla.swift
//  Bingo
//
//  Created by alumno on 16/05/25.
//

import SwiftUI

struct GanastePantalla: View {
    @Environment(\.dismiss) var dismiss
    let volverInicio: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("¡Ganaste! ")
                .font(.system(size: 55, weight: .black, design: .rounded))
                .foregroundStyle(
                    LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                )
            
            
            Text("¡Felicidades, hiciste bingo!")
                .font(.title3)
                .foregroundColor(.purple.opacity(0.8))
                .multilineTextAlignment(.center)
            
            
            Button(action: {
                volverInicio()
            }) {
                Text("Volver al Inicio")
                    .font(.title3.bold())
                    .padding()
                    .frame(width: 250)
                    .background(
                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                    )
                    .foregroundColor(.white)
                    .clipShape(Capsule())
                    .shadow(color: .pink.opacity(0.4), radius: 10, x: 0, y: 5)
            }
            .buttonStyle(ScaleButtonStyle())
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(colors: [.white, .pink.opacity(0.1)], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    GanastePantalla( volverInicio: {} )
}

