//
//  SwiftDataViewModel.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 06/05/2024.
//

import Foundation

class SwiftDataViewModel: ObservableObject {
    @Published var index: Int?
    @Published var selectedItem: SwiftDataCardModel = SwiftDataCardModel(name: "", address: "")
}
