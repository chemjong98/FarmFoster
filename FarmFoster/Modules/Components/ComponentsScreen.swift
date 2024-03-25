//
//  ComponentsScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 31/01/2024.
//

import SwiftUI

struct ComponentsScreen: View {
    // MARK: - properties
    @StateObject private var viewModel: ComponentsViewModel

    init(viewModel: ComponentsViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading) {
            Text(LocalizedString.componentList.key)
                .font(.custom(AppFont.bold.font, size: 28))

            ForEach(componentsList.allCases, id: \.self) { item in
                listItemView(item: item)
            }
            .background(AppColor.lightGray.color)

            Spacer()
        }
        .padding(.horizontal, 16)
    }

    // MARK: - listItemView
    func listItemView(item: componentsList) -> some View {
        HStack(alignment: .center) {
            Text(item.key.capitalized)
                .padding(.vertical, 8)
            Spacer()
        }
        .padding(.leading, 8)
        .background(AppColor.lightGray.color)
        .clipped()
        .onTapGesture {
            print("hello")
            switch item {
            case .map:
                viewModel.goTomap()
            case .shader:
                viewModel.goToShader()
            case .carousel:
                viewModel.goTomap()
            }
        }
    }
}

//#Preview {
//    ComponentsScreen()
//}
