//
//  BingoNumero.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import Foundation

// Estructura para la respuesta de la API
struct BingoNumeroRespuesta: Decodable {
    let letter: String
    let number: Int
}


struct BingoCarta: Identifiable {
    let id = UUID()
    let numeroCelda: Int?
    var isMarked: Bool = false
}

func generateRandomNumbers(range: ClosedRange<Int>) -> [Int] {
    var numbers: Set<Int> = []
    while numbers.count < 5 {
        let number = Int.random(in: range)
        numbers.insert(number)
    }
    return Array(numbers).sorted()
}

// Función para generar la carta de bingo
func generateBingoCard() -> [[BingoCarta]] {
    var card: [[BingoCarta]] = []

    let bNumbers = generateRandomNumbers(range: 1...15)
    let iNumbers = generateRandomNumbers(range: 16...30)
    let nNumbers = generateRandomNumbers(range: 31...45)
    let gNumbers = generateRandomNumbers(range: 46...60)
    let oNumbers = generateRandomNumbers(range: 61...75)

    for row in 0..<5 {
        var rowCells: [BingoCarta] = []
        rowCells.append(BingoCarta(numeroCelda: bNumbers[row]))
        rowCells.append(BingoCarta(numeroCelda: iNumbers[row]))
        
        // Asegúrate de que no haya problemas con el espacio libre
        if row == 2 {
            rowCells.append(BingoCarta(numeroCelda: nil)) // Espacio libre
        } else {
            rowCells.append(BingoCarta(numeroCelda: nNumbers[row]))
        }
        
        rowCells.append(BingoCarta(numeroCelda: gNumbers[row]))
        rowCells.append(BingoCarta(numeroCelda: oNumbers[row]))
        
        card.append(rowCells)
    }
    return card
}

