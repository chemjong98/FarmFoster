//
//  HomeScreenViewModel.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import Foundation
import Combine

enum HomeRoutables: ScreenRoutable {
    case itemSpecificScren(disease: [ItemDiseaseModel])
}

class HomeScreenViewModel: ObservableObject {
    // MARK: -  properties
    @Published var selection: farmType = .plants
    @Published var disease: [ItemDiseaseModel] = []
    @Published var animals: [Animals] = []
    @Published var plants: [Plants] = []
    @Published var errorMessage = ""
    
    private var cancellable = Set<AnyCancellable>()
    
    var onRouteTrigger: ((HomeRoutables) -> Void)?
    let client: AnimalClient
    let plantClient: PlantClient

    // MARK: - init
    init(client: AnimalClient, plantClient: PlantClient) {
        self.client = client
        self.plantClient = plantClient
        Task {
//            await
            getItemDisease()
        }
        
        getPlants()
    }
    
    func  mals() {
        Task {
            do {
                self.animals = try await client.getAnimalList()
            } catch let error as AppError {
                errorMessage = error.errorDescription ?? ""
            }
        }
    }
    
    func getPlants() {
        Task {
            do {
                self.plants = try await plantClient.getPlants()
            } catch let error as AppError {
                errorMessage = error.errorDescription ?? ""
            }
        }
    }

    func getItemDisease() {
//        guard let url = URL(string: "http://localhost:5000/itemModel") else { return }
//        client.fetch(requestUrl: url, resultType: [ItemDiseaseModel].self) { [weak self] result in
//            guard let self = self else {return}
//            
//            DispatchQueue.main.async {
//                self.disease = result
//            }
//        }
        print("")
    }

    // MARK: - goToItemSpecificScreen
    func goToItemSpecificScreen(disease: [ItemDiseaseModel]) {
        onRouteTrigger?(HomeRoutables.itemSpecificScren(disease: disease))
    }


}
