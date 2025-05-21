//
//  GameView.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import SwiftUI

struct GameView: View {
    @Binding var pantallaActual: PantallaActual
    @State private var numActual: Int? = nil
    @State private var selecNum: [Int] = []
    @State private var Cagando = false
    @State private var bingoCard: [[BingoCarta]] = []
    @State private var ganasteMenso: Bool = false
    @State private var GanastePant = false
    @State private var mostrarPausa = false

    let api = BingoAPI()

    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [.white, .pink.opacity(0.1)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("BINGO")
                    .font(.system(size: 60, weight: .black, design: .rounded))
                    .foregroundStyle(
                        LinearGradient(colors: [.pink, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    )


                if let number = numActual {
                    Text("Número actual: \(number)")
                        .font(.title2.bold())
                        .foregroundColor(.pink)
                } else {
                    Text("Presiona el botón para comenzar")
                        .foregroundColor(.gray)
                }

                Button(action: { fetchNewNumber() }) {
                    Text(Cagando ? "Cargando..." : "Sacar Número")
                        .font(.title2.bold())
                                    .padding()
                                    .frame(width: 200)
                                    .background(
                                        LinearGradient(colors: [.pink, .purple], startPoint: .leading, endPoint: .trailing)
                                    )
                                    .foregroundColor(.white)
                                    .clipShape(Capsule())
                                    .shadow(color: .pink.opacity(0.4), radius: 10, x: 0, y: 5)
                            }
                            .buttonStyle(ScaleButtonStyle())
                            .disabled(Cagando)
                
                Button(action: {
                    mostrarPausa = true
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundStyle(
                            LinearGradient(colors: [.pink, .purple], startPoint: .top, endPoint: .bottom)
                        )
                }
                .sheet(isPresented: $mostrarPausa) {
                    PausaPantalla(
                        volverJuego: {
                            pantallaActual = .juego
                            mostrarPausa = false
                        },
                        volverInicio: {
                            pantallaActual = .inicio
                            mostrarPausa = false
                        }
                    )
                }



                Divider()

                Text("Tu Carta")
                    .font(.headline)
                    .foregroundColor(.pink)

                VStack(spacing: 5) {
                    ForEach(0..<5, id: \.self) { row in
                        HStack(spacing: 5) {
                            ForEach(0..<5, id: \.self) { col in
                                if row < bingoCard.count && col < bingoCard[row].count {
                                    let cell = bingoCard[row][col]
                                    Button(action: {
                                        if let num = cell.numeroCelda, selecNum.contains(num) {
                                            bingoCard[row][col].isMarked.toggle()
                                        }
                                    }) {
                                        ZStack {
                                            RoundedRectangle(cornerRadius: 10)
                                                .fill(cell.isMarked ? Color.pink.opacity(0.8) : Color.white)
                                                .frame(width: 55, height: 55)
                                                .shadow(color: .pink.opacity(0.2), radius: 3)

                                            if let number = cell.numeroCelda {
                                                Text("\(number)")
                                                    .foregroundColor(.black)
                                                    .bold()
                                            } else {
                                                Text("FREE")
                                                    .foregroundColor(.gray)
                                                    .bold()
                                                    .font(.caption)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal)

                Divider()

                Text("Números sorteados:")
                    .font(.headline)
                    .foregroundColor(.pink)

                ScrollView(.horizontal) {
                    HStack {
                        ForEach(selecNum, id: \.self) { number in
                            Text("\(number)")
                                .padding(8)
                                .background(Color.pink.opacity(0.8))
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .padding()
        }
        .onAppear {
            bingoCard = generateBingoCard()
        }
        .fullScreenCover(isPresented: $GanastePant) {
                GanastePantalla(volverInicio: {
                    pantallaActual = .inicio
                    GanastePant = false
                })
            }


    }
    

    func fetchNewNumber(retries: Int = 5) {
        guard retries > 0 else {
            print("Error: No se pudo obtener un número válido.")
            return
        }

        Cagando = true
        api.fetchBingoNumber { num in
            DispatchQueue.main.async {
                self.Cagando = false

                guard let num = num else {
                    print("Número recibido es nil.")
                    return
                }

                if self.selecNum.contains(num) {
                    print("Número repetido: \(num).")
                } else {
                    self.numActual = num
                    self.selecNum.append(num)
                }

                for i in 0..<5 {
                    for j in 0..<5 {
                        if bingoCard[i][j].numeroCelda == num {
                            bingoCard[i][j].isMarked = true
                        }
                    }
                }

                if Ganaste() {
                    ganasteMenso = true
                    GanastePant = true
                    print("¡Ganaste mensa!")
                }
            }
        }
    }

    func Ganaste() -> Bool {
        for row in bingoCard {
            if row.filter({ $0.isMarked || $0.numeroCelda == nil }).count == 5 {
                return true
            }
        }
        for col in 0..<5 {
            var columnMarked = 0
            for row in 0..<5 {
                let cell = bingoCard[row][col]
                if cell.isMarked || cell.numeroCelda == nil {
                    columnMarked += 1
                }
            }
            if columnMarked == 5 {
                return true
            }
        }
        var diagonal1 = 0
        for i in 0..<5 {
            let cell = bingoCard[i][i]
            if cell.isMarked || cell.numeroCelda == nil {
                diagonal1 += 1
            }
        }
        if diagonal1 == 5 {
            return true
        }
        var diagonal2 = 0
        for i in 0..<5 {
            let cell = bingoCard[i][4 - i]
            if cell.isMarked || cell.numeroCelda == nil {
                diagonal2 += 1
            }
        }
        if diagonal2 == 5 {
            return true
        }
        return false
    }
}


#Preview {
    GameView(pantallaActual: .constant(.juego))
}


