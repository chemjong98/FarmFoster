//
//  ComponentsViewModel.swift
//  FarmFoster
//
//  Created by ebpearls on 31/01/2024.
//

import Foundation

class baseViewModel: ObservableObject {

    init() {
        print("init")
    }

    deinit {
        print("deinit")
    }

}

enum componentsList: String, CaseIterable {
    case map
    case shader
    case carousel

    var key: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}

enum componentListRoutable: ScreenRoutable {
    case mapScreen
    case shaderScreen
}

// MARK: - ComponentsViewModel
class ComponentsViewModel: baseViewModel {
    
    // MARK: - properties
    var onRouteTrigger: ((ScreenRoutable) -> Void)?
}

// extension
extension ComponentsViewModel {
    func goTomap() {
        onRouteTrigger?(componentListRoutable.mapScreen)
    }

    func goToShader() {
        onRouteTrigger?(componentListRoutable.shaderScreen)
    }
}
