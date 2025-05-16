//
//  BingoAPI.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import Foundation

class BingoAPI {
    func fetchBingoNumber(completion: @escaping (Int?) -> Void) {
        let urlString = "https://www.randomnumberapi.com/api/v1.0/random?min=1&max=75&count=1"
        guard let url = URL(string: urlString) else {
            print("URL inválida")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }
            if let data = data {
                do {
                    if let numbers = try JSONSerialization.jsonObject(with: data, options: []) as? [Int],
                       let number = numbers.first {
                        DispatchQueue.main.async {
                            completion(number)
                        }
                    } else {
                        print("Error al decodificar JSON")
                        DispatchQueue.main.async {
                            completion(nil)
                        }
                    }
                } catch {
                    print("Error al parsear JSON: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            } else {
                print("No se recibió data")
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }.resume()
    }
}
 



 
