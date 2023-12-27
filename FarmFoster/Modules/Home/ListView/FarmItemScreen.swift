//
//  PlantScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

struct FarmItemScreen: View {
    // MARK: - properties
     private var selectionType: farmType
    private var image: Image

    // MARK: - init
    init(selectionType: farmType, image: Image) {
        self.selectionType = selectionType
        self.image = image
    }

    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
          
            if selectionType == .plants {
                image
                    .resizable()
//                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 8, bottomLeading: 8, bottomTrailing: 8, topTrailing: 8)))
                    .clipShape(Rectangle())
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    }
            } else {
                AppImage.horse.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Rectangle())
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    }
            }

            Text((selectionType == .plants) ? "Blueberry" : "Horse")
                .font(.custom(AppFont.regular.font, size: 16))

        }
    }
}

//#Preview {
//    FarmItemScreen(selectionType: .plants)
//}
