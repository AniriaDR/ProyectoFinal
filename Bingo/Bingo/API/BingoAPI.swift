//
//  BingoAPI.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import Foundation

class BingoAPI {
    func fetchBingoNumber(completion: @escaping (Int?) -> Void) {
        let urlString = "https://bingo-api-adamrmelnyk.vercel.app/api/bingo"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data,
               let decoded = try? JSONDecoder().decode(BingoNumeroRespuesta.self, from: data) {
                DispatchQueue.main.async {
                    completion(decoded.number)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
 
