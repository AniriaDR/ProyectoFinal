//
//  ContentView.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import SwiftUI

enum PantallaActual {
    case inicio, juego, ganaste, pausa
}

struct ContentView: View {
    @State private var pantallaActual: PantallaActual = .inicio {
        didSet {
            print("DEBUG - Pantalla cambiada a: \(pantallaActual)")
        }
    }
    
    var body: some View {
        ZStack {
            Color(.systemBackground).ignoresSafeArea()
            
            switch pantallaActual {
            case .inicio:
                InicioPantalla(pantallaActual: $pantallaActual)
            case .juego:
                GameView(pantallaActual: $pantallaActual)
                    .transition(.opacity)
            case .ganaste:
                GanastePantalla(volverInicio: {
                    withAnimation {
                        pantallaActual = .inicio
                    }
                })
            case .pausa:
                PausaPantalla(
                    volverJuego: {
                        withAnimation {
                            pantallaActual = .juego
                        }
                    },
                    volverInicio: {
                        withAnimation {
                            pantallaActual = .inicio
                        }
                    }
                )
            }
        }
        .animation(.default, value: pantallaActual)
    }
}

#Preview {
    ContentView()
}


