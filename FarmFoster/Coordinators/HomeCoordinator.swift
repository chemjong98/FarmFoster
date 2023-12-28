//
//  HomeCoordinator.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
import FlowStacks

public protocol ScreenRoutable {}

enum HomeRoutes: Equatable {
    case home
    case itemspecific(disease: [DiseaseModel])
}

struct HomeCoordinator: View {
    // MARK: - properties
    @State private var routes: Routes<HomeRoutes> = [.root(.home, embedInNavigationView: true)]
    private var client: NetworkClient
    
    init(client: NetworkClient) {
        self.client = client
    }

    // MARK: -  body
    var body: some View {
        Router($routes) { screen, _ in
            switch screen {
                case .itemspecific(let disease):
                itemDetailScreen(viewModel: {
                    let viewModel = ItemDetailViewModel()
                    viewModel.disease = disease
                    return viewModel
                }())

            case .home:
                HomeScreen(viewModel: {
                    let viewModel = HomeScreenViewModel(networkClient: client)
                    viewModel.onRouteTrigger = handleFlowRoute()
                    return viewModel
                }())
                .hideTabBarOnPush(routes: $routes)
            }
        }
    }

    func showItemSpecificScreen(disease: [DiseaseModel]) {
        routes.push(.itemspecific(disease: disease))
    }

    func handleFlowRoute() -> ((ScreenRoutable) -> Void)   {
        return {
            Route in
            switch Route {
            case HomeRoutables.itemSpecificScren(let disease):
                showItemSpecificScreen(disease: disease)
            default:
                break
            }
        }
    }
}

