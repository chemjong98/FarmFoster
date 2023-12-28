//
//  NetworkClient.swift
//  FarmFoster
//
//  Created by ebpearls on 28/12/2023.
//

import Foundation
import SwiftUI

enum AppError: Error {
    case invalidURL
    case invalidResponse
    case unknown
}

struct NetworkClient {
    func fetch<T:Decodable>(requestUrl: URL, resultType: T.Type, completionHandler: @escaping(_ result: T)->Void) {
        let task =  URLSession.shared.dataTask(with: requestUrl ){ data, response , error in

            if let error = error {
                print(error)
            } else {

                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    print("Invalid response")
                    return
                }

                guard let data = data else { return }
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(T.self, from: data)
                    completionHandler(responseData)
                } catch  {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
