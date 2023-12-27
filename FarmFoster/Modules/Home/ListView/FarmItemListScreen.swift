//
//  PlantListScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

struct FarmItemListScreen: View {
    @ObservedObject private var viewModel: HomeScreenViewModel
    @Binding var selectionType: farmType
    private let image: [Image] = [AppImage.blueBerry.image, AppImage.blueBerry2.image, AppImage.blueBerry2.image, AppImage.blueBerry.image]

    init(viewModel: HomeScreenViewModel, selectionType: Binding<farmType>) {
        self.viewModel = viewModel
        self._selectionType = selectionType
    }

    @State var column: [GridItem] = [
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width*0.4, maximum: UIScreen.main.bounds.width*0.4), spacing: UIScreen.main.bounds.width*0.1, alignment: .leading),
        GridItem(.adaptive(minimum: UIScreen.main.bounds.width*0.4, maximum: UIScreen.main.bounds.width*0.4), spacing: UIScreen.main.bounds.width*0.1, alignment: .leading)
        ]

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
                            viewModel.goToItemSpecificScreen()
                        }
                }
            }

        }

    }
}

#Preview {
    FarmItemListScreen(viewModel: HomeScreenViewModel(), selectionType: .constant(.plants) )
}
