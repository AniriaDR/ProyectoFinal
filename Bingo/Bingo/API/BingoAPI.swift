//
//  BingoAPI.swift
//  Bingo
//
//  Created by alumno on 09/05/25.
//

import Foundation

class BingoAPI {
    func fetchBingoNumber(completion: @escaping (Int?) -> Void) {
        //let urlString = "https://bingo-api-adamrmelnyk.vercel.app/api/bingo"
        //guard let url = URL(string: urlString) else {
          //  print("URL inválida")
            //completion(nil)
            //return
            let randomNumber = Int.random(in: 1...75)
                    DispatchQueue.main.async {
                        completion(randomNumber)
        }
/*/
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error de red: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(nil)
                }
                return
            }

            if let data = data {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Respuesta JSON: \(jsonString)")
                }

                if let decoded = try? JSONDecoder().decode(BingoNumeroRespuesta.self, from: data) {
                    DispatchQueue.main.async {
                        print("Número recibido desde API: \(decoded.number)")
                        completion(decoded)
                    }
                } else {
                    print("Error al decodificar JSON")
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
        }.resume()*/
    }
}



 
