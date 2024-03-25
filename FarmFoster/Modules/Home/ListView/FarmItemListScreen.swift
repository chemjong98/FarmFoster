//
//  PlantListScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

struct FarmItemListScreen: View {
    // MARK: - properties
    @ObservedObject private var viewModel: HomeScreenViewModel
    
    @State var column: [GridItem] = [GridItem(.fixed(UIScreen.main.bounds.width*0.45), spacing: UIScreen.main.bounds.width*0.07),
                                     GridItem(.fixed(UIScreen.main.bounds.width*0.4))
    ]
    
    // MARK: - init
    init(viewModel: HomeScreenViewModel) {
        self.viewModel = viewModel
    }
    
    // MARK: - body
    var body: some View {
        ScrollView(showsIndicators: false) {
            LazyVGrid(columns: column, alignment: .center, spacing: UIScreen.main.bounds.width*0.1) {
                if viewModel.selection == .animals {
                    animalListView()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                    //                .background{
                    //                    RoundedRectangle(cornerRadius: 8)
                    //                        .stroke(AppColor.appGray.color, lineWidth: 1)
                    //                }
                    //                .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                if viewModel.selection == .plants {
                    plantListView()
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                
                
            }
            
        }
    }
    @ViewBuilder
    private func animalListView() -> some View {
        ForEach(viewModel.animals, id: \.self) { item in
            FarmItemScreen(animal: item)
            //                        .frame(width: UIScreen.main.bounds.width *)
                .frame(height: 120)
                .scaledToFit()
                .onTapGesture {
                    viewModel.goToItemSpecificScreen(disease: viewModel.disease)
                }
        }
    }
    
    @ViewBuilder
    private func plantListView() -> some View {
        ForEach(viewModel.plants, id: \.self) { item in
            FarmItemScreen(plant: item)
                .frame(height: 120)
                .scaledToFit()
                .onTapGesture {
                    viewModel.goToItemSpecificScreen(disease: viewModel.disease)
                }
        }
    }
}
    
    

#Preview {
    FarmItemListScreen(viewModel: HomeScreenViewModel(client: AnimalClient(client: NetworkClient.shared), plantClient: PlantClient(client: NetworkClient.shared)))
}
