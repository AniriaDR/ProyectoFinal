//
//  GameView.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import SwiftUI
 
struct GameView: View {
    @State private var currentNumber: Int?
    @State private var drawnNumbers: [Int] = []
    @State private var isLoading = false
    @State private var bingoCard: [[BingoCarta]] = []
 
    let api = BingoAPI() // Instancia de la clase API
 
    var body: some View {
        VStack(spacing: 20) {
            Text("BINGO")
                .font(.largeTitle)
                .fontWeight(.bold)
 
            if let number = currentNumber {
                Text("Número actual: \(number)")
                    .font(.title)
                    .foregroundColor(.blue)
            } else {
                Text("Presiona el botón para comenzar")
                    .foregroundColor(.gray)
            }
 
            Button(action: fetchNewNumber) {
                Text(isLoading ? "Cargando..." : "Sacar Número")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .disabled(isLoading)
 
            Divider()
 
            Text("Tu Carta")
                .font(.headline)
 
            VStack(spacing: 5) {
                ForEach(0..<5, id: \.self) { row in
                    HStack(spacing: 5) {
                        ForEach(0..<5, id: \.self) { col in
                            let cell = bingoCard[row][col]
                            Button(action: {
                                if let num = cell.number, drawnNumbers.contains(num) {
                                    bingoCard[row][col].isMarked.toggle()
                                }
                            }) {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 8)
                                        .fill(cell.isMarked ? Color.blue : Color.gray.opacity(0.3))
                                        .frame(width: 50, height: 50)
 
                                    if let number = cell.number {
                                        Text("\(number)")
                                            .foregroundColor(.black)
                                    } else {
                                        Text("FREE")
                                            .foregroundColor(.black)
                                            .font(.caption)
                                    }
                                }
                            }
                        }
                    }
                }
            }
 
            Divider()
 
            Text("Números sorteados:")
                .font(.headline)
 
            ScrollView(.horizontal) {
                HStack {
                    ForEach(drawnNumbers, id: \.self) { number in
                        Text("\(number)")
                            .padding(8)
                            .background(Color.orange)
                            .foregroundColor(.white)
                            .cornerRadius(6)
                    }
                }
            }
 
            Spacer()
        }
        .padding()
        .onAppear {
            bingoCard = generateBingoCard()
        }
    }
 
    func fetchNewNumber() {
        isLoading = true
        api.fetchBingoNumber { num in
            DispatchQueue.main.async {
                isLoading = false
                if let num = num, !drawnNumbers.contains(num) {
                    currentNumber = num
                    drawnNumbers.append(num)
                }
            }
        }
    }
}
#Preview {
    GameView()
}
