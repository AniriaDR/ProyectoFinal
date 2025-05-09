//
//  CartaBingo.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import Foundation
// generar números aleatorios dentro de un rango
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
    // Generar columnas para cada letra BINGO
    let bNumbers = generateRandomNumbers(range: 1...15)
    let iNumbers = generateRandomNumbers(range: 16...30)
    let nNumbers = generateRandomNumbers(range: 31...45)
    let gNumbers = generateRandomNumbers(range: 46...60)
    let oNumbers = generateRandomNumbers(range: 61...75)
    // Crear las filas de la carta
    for row in 0..<5 {
        var rowCells: [BingoCarta] = []
        rowCells.append(BingoCarta(id: <#T##Int#>, numeroCelda: bNumbers[row])) // Columna B
        rowCells.append(BingoCarta(id: <#T##Int#>, numeroCelda: iNumbers[row])) // Columna I
        if row == 2 {
            rowCells.append(BingoCarta(id: <#T##Int#>, numeroCelda: nil)) // Columna N (espacio libre en el centro)
        } else {
            rowCells.append(BingoCarta(id: <#T##Int#>, numeroCelda: nNumbers[row])) // Columna N
        }
        rowCells.append(BingoCarta(id: <#T##Int#>, numeroCelda: gNumbers[row])) // Columna G
        rowCells.append(BingoCarta(id: <#T##Int#>, numeroCelda: oNumbers[row])) // Columna O
        card.append(rowCells)
    }
    return card
}
 
