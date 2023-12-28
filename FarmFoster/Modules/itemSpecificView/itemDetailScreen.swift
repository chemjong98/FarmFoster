//
//  itemDetailScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI

struct itemDetailScreen: View {
    // MARK: - properties
    @StateObject  var viewModel: ItemDetailViewModel

    init(viewModel: ItemDetailViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
           Text("Disease")
                .font(.custom(AppFont.bold.font, size: 28))
                .foregroundStyle(.navyBlue)

            LazyVStack(content: {
                ForEach(viewModel.disease, id: \.self) { disease in
                   diseaseItem(disease: disease)
                }
            })
        }
       

    }

    @ViewBuilder
    func diseaseItem(disease: DiseaseModel) -> some View {
        VStack {
            Text(disease.name)

//            Text(disease.symptoms)
        }
    }
}

#Preview {
    itemDetailScreen(viewModel: ItemDetailViewModel() )
}
