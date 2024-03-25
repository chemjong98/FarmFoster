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
            }
        }
    }

    func showMap() {
        routes.push(.map)
    }

    func showShader() {
        routes.push(.shader)
    }

    func handleFlowRoutes() -> (ScreenRoutable) -> Void {
        return { routes in
            switch routes {
            case componentListRoutable.mapScreen:
                showMap()

            case componentListRoutable.shaderScreen:
                showShader()

            default:
                break
            }
        }
    }
}

