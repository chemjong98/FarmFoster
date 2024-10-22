//
//  ComponentsCoordinator.swift
//  FarmFoster
//
//  Created by ebpearls on 31/01/2024.
//

import SwiftUI
import FlowStacks

struct ComponentsCoordinator: View {
    // MARK: - properties
    @State private var routes: Routes<ComponentsRoutes> = [.root(.componentList, embedInNavigationView: true)]

    // MARK: - body
    var body: some View {
        Router($routes) { screen, _ in
            switch screen {
            case .componentList:
                ComponentsScreen(viewModel: {
                    let viewModel = ComponentsViewModel()
                    viewModel.onRouteTrigger = handleFlowRoutes()
                    return viewModel
                }())
            case .map:
                MapScreen()
            case .shader:
                MapScreen()
            case .mediaPicker:
                MediaPickerScreen(viewModel: MediaPickerViewModel())
            case .textFields:
                TextFieldsScreen(viewModel: TextFieldsViewModel())
                
            case .swiftDataCards:
                SwiftDataScreen(viewModel: SwiftDataViewModel())
            case .multipleMediaPicker:
                MediaPickerScreen(viewModel: MediaPickerViewModel(), singlePicker: false)
            case .slider:
                SliderScreen()
            }
        }
    }

    func showMap() {
        routes.push(.map)
    }

    func showShader() {
        routes.push(.shader)
    }
    
    func showMediaPicker() {
        routes.push(.mediaPicker)
    }
    
    func showTextFields() {
        routes.push(.textFields)
    }

    func showSwiftDataCards() {
        routes.push(.swiftDataCards)
    }
    
    func showMultipleMediaPicker() {
        routes.push(.multipleMediaPicker)
    }
    
    func showSlider() {
        routes.push(.slider)
    }
    
    func handleFlowRoutes() -> (ScreenRoutable) -> Void {
        return { routes in
            switch routes {
            case componentListRoutable.mapScreen:
                showMap()

            case componentListRoutable.shaderScreen:
                showShader()
                
            case componentListRoutable.mediaPickerScreen:
                showMediaPicker()
                
            case componentListRoutable.textFields:
                showTextFields()
                
            case componentListRoutable.swiftDataCards:
                showSwiftDataCards()

            case componentListRoutable.multipleMediaPickerScreen:
                showMultipleMediaPicker()
                
            case componentListRoutable.slider:
                showSlider()
                
            default:
                break
            }
        }
    }
}

