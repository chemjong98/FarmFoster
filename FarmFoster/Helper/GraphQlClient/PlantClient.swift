//
//  PlantClient.swift
//  FarmFoster
//
//  Created by ebpearls on 21/03/2024.
//

import Foundation
import FarmFosterAPI
import Apollo

typealias Plants = GetPlantListQuery.Data.GetAllPlants.Plant
protocol PlantClientManageable {
    func getPlants() async throws -> [Plants]
}

class PlantClient {
    private let client: GraphQLClient
    
    init(client: GraphQLClient) {
        self.client = client
    }
}

extension PlantClient: PlantClientManageable {
    func getPlants() async throws -> [Plants] {
        let query = GetPlantListQuery()
        let result = await client.fetch(query: query, cacahePolicy: .fetchIgnoringCacheCompletely)
        
        switch result {
            case .success(let response):
            if let plants = response.data?.getAllPlants.plants {
                return plants
            }
            
        case .failure(let error):
            throw AppError.custom(error.errorDescription ?? "")
        }
        
        throw AppError.unknown
    }
    
    
}
