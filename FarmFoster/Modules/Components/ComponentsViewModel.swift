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
//    case none
    case map
    case shader
    case carousel
    case mediaPicker
    case TextFields
    case swiftDataCards
    case slider

    var key: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}

enum componentListRoutable: ScreenRoutable {
    case mapScreen
    case shaderScreen
    case mediaPickerScreen
    case multipleMediaPickerScreen
    case textFields
    case swiftDataCards
    case slider
}

// MARK: - ComponentsViewModel
class ComponentsViewModel: baseViewModel {
    
    // MARK: - properties
    @Published var selectedItem: componentsList?
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
    
    func goToMediaPicker() {
        onRouteTrigger?(componentListRoutable.mediaPickerScreen)
    }
    
    func goToTextFields() {
        onRouteTrigger?(componentListRoutable.textFields)
    }
    
    func goTocards() {
        onRouteTrigger?(componentListRoutable.swiftDataCards)
    }
    
    func goToMediaPickerMultiple() {
        onRouteTrigger?(componentListRoutable.multipleMediaPickerScreen)
    }
    
    func goToSlider() {
        onRouteTrigger?(componentListRoutable.slider)
    }
}
