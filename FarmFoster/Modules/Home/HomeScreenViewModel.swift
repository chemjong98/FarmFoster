//
//  HomeScreenViewModel.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import Foundation

enum HomeRoutables: ScreenRoutable {
    case itemSpecificScren
}

class HomeScreenViewModel: ObservableObject {
    @Published var selection: farmType = .plants
    var onRouteTrigger: ((HomeRoutables) -> Void)?

    func goToItemSpecificScreen() {
        onRouteTrigger?(HomeRoutables.itemSpecificScren)
    }
}
