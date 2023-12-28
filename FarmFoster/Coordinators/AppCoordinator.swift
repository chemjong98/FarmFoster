//
//  AppCoordinator.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
import FlowStacks

struct AppCoordinator: View {
    // MARK: - properties
    @State var routes: Routes<AppRoutes> = [.root(.mainTabRoute)]
    private var client = NetworkClient()

    // MARK: -  body
    var body: some View {
        Router($routes) { screen, _ in
            switch screen {
            case .mainTabRoute:
                MainTabCoordinator(client: client)
            }
        }
    }
}

#Preview {
    AppCoordinator()
}
