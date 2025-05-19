//
//  GameView.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import SwiftUI

struct GameView: View {
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
            LinearGradient(colors: [Color.pink.opacity(0.2), Color.white], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Text("BINGO ROSITA ")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.pink)

                if let number = numActual {
                    Text("Número actual: \(number)")
                        .font(.title)
                        .foregroundColor(.pink)
                } else {
                    Text("Presiona el botón para comenzar")
                        .foregroundColor(.gray)
                }

                Button(action: { fetchNewNumber() }) {
                    Text(Cagando ? "Cargando..." : "Sacar Número")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.pink)
                        .foregroundColor(.white)
                        .font(.headline)
                        .cornerRadius(12)
                        .shadow(radius: 5)
                }
                .disabled(Cagando)
                .padding(.horizontal, 40)
                
                Button(action: {
                    mostrarPausa = true
                }) {
                    Image(systemName: "pause.circle.fill")
                        .resizable()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.pink)
                }
                .sheet(isPresented: $mostrarPausa) {
                    PausaPantalla()
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
            GanastePantalla()
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
    GameView()
}

