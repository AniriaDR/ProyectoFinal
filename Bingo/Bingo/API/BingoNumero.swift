//
//  BingoNumero.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import Foundation

struct BingoNumeroRespuesta: Decodable {
    let number: Int
}

struct BingoCarta: Identifiable {
    let id: Int
    let numeroCelda: Int?
    var isMarked: Bool = false
}
