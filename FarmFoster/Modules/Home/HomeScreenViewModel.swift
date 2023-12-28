//
//  HomeScreenViewModel.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import Foundation

enum HomeRoutables: ScreenRoutable {
    case itemSpecificScren(disease: [DiseaseModel])
}

class HomeScreenViewModel: ObservableObject {
    // MARK: -  properties
    @Published var selection: farmType = .plants
    @Published var disease: [DiseaseModel] = []
    var onRouteTrigger: ((HomeRoutables) -> Void)?
    let client: NetworkClient

    // MARK: - init
    init(networkClient: NetworkClient) {
        self.client = networkClient
        Task {
            await getItemDisease()
        }
    }

    func getItemDisease() {
        guard let url = URL(string: "http://localhost:3000/Disease") else { return }
        client.fetch(requestUrl: url, resultType: [DiseaseModel].self) { [weak self] result in
            guard let self = self else {return}
            
            DispatchQueue.main.async {
                self.disease.append(contentsOf: result)
            }
        }
    }

    // MARK: - goToItemSpecificScreen
    func goToItemSpecificScreen(disease: [DiseaseModel]) {
        onRouteTrigger?(HomeRoutables.itemSpecificScren(disease: disease))
    }


}
