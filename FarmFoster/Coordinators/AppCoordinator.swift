//
//  AppCoordinator.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
import FlowStacks

struct AppCoordinator: View {
    @State var routes: Routes<AppRoutes> = [.root(.mainTabRoute)]
    var body: some View {
        Router($routes) { screen, _ in
            switch screen {
            case .mainTabRoute:
               MainTabCoordinator()
            }
        }
    }
}

#Preview {
    AppCoordinator()
}
