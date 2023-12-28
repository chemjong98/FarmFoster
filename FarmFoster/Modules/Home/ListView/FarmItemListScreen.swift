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
    @Binding var selectionType: farmType

    @State var column: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width*0.4, maximum: UIScreen.main.bounds.width*0.4), spacing: UIScreen.main.bounds.width*0.1, alignment: .leading),
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width*0.4, maximum: UIScreen.main.bounds.width*0.4), spacing: UIScreen.main.bounds.width*0.1, alignment: .leading)
        ]


    private let image: [Image] = [AppImage.blueBerry.image, AppImage.blueBerry2.image, AppImage.blueBerry2.image, AppImage.blueBerry.image]


    // MARK: - init
    init(viewModel: HomeScreenViewModel, selectionType: Binding<farmType>) {
        self.viewModel = viewModel
        self._selectionType = selectionType
    }

    // MARK: - body
    var body: some View {
        ScrollView {
            LazyVGrid(columns: column, alignment: .leading) {
                ForEach(image.indices) { index in
                    let type = self.selectionType
                    FarmItemScreen(selectionType: type, image: image[index])
                        .frame(maxWidth: .infinity)
                        .frame(height: 120)
                        .scaledToFit()
                        .onTapGesture {
                            viewModel.goToItemSpecificScreen(disease: viewModel.disease)
                        }
                }
            }

        }

    }
}

#Preview {
    FarmItemListScreen(viewModel: HomeScreenViewModel(networkClient: NetworkClient()), selectionType: .constant(.plants) )
}
