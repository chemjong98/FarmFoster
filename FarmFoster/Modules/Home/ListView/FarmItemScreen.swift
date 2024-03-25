//
//  PlantScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

struct FarmItemScreen: View {
    // MARK: - properties
    private var animal: Animals?
    private var plant: Plants?

    // MARK: - init
    init( animal: Animals? = nil, plant: Plants? = nil) {
        self.animal = animal
        self.plant = plant
    }

    // MARK: - body
    var body: some View {
        VStack(alignment: .leading) {
                AppImage.horse.image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Rectangle())
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: /*@START_MENU_TOKEN@*/1.0/*@END_MENU_TOKEN@*/)
                    }

            if let plant = plant {
                Text(plant.name)
                .font(.custom(AppFont.regular.font, size: 16))
            }
            
            if let animal = animal {
                Text(animal.name)
                    .font(.custom(AppFont.regular.font, size: 16))
            }

        }
    }
}

//#Preview {
//    FarmItemScreen(selectionType: .plants, animal: [Animals] = [])
//}
