//
//  AnimalClient.swift
//  FarmFoster
//
//  Created by ebpearls on 20/03/2024.
//

import Foundation
import FarmFosterAPI

typealias Animals = GetAnimalListQuery.Data.GetAllAnimals.Animal
protocol AnimalClentManageable {
    func getAnimalList() async throws -> [Animals]
}

class AnimalClient {
    private let client: GraphQLClient
    init(client: GraphQLClient) {
        self.client = client
    }
}

extension AnimalClient: AnimalClentManageable {
    func getAnimalList() async throws -> [Animals] {
        let query = GetAnimalListQuery()
        let result = await client.fetch(query: query, cacahePolicy: .fetchIgnoringCacheCompletely)
        
        switch result {
        case .success(let result):
            if let animals = result.data?.getAllAnimals.animals {
                return animals
            }
        case .failure(let error):
           throw AppError.custom(error.localizedDescription)
        }
        
        throw AppError.unknown
    }
}
