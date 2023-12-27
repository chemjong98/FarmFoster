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
    case itemspecific
}

struct HomeCoordinator: View {
    @State private var routes: Routes<HomeRoutes> = [.root(.home, embedInNavigationView: true)]
    var body: some View {
        Router($routes) { screen, _ in
            switch screen {
                case .itemspecific:
                    itemDetailScreen()
            case .home:
                HomeScreen(viewModel: {
                    let viewModel = HomeScreenViewModel()
                    viewModel.onRouteTrigger = handleFlowRoute()
                    return viewModel
                }())
                .hideTabBarOnPush(routes: $routes)
            }
        }
    }

    func showItemSpecificScreen() {
        routes.push(.itemspecific)
    }

    func handleFlowRoute() -> ((ScreenRoutable) -> Void)  {
        return {
            Route in
            switch Route {
            case HomeRoutables.itemSpecificScren:
                showItemSpecificScreen()
            default:
                break
            }
        }
    }
}

