//
//  MainTabCoordinator.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
enum Tabs {
    case home
    case setting
}

struct MainTabCoordinator: View {
    // MARK: - properties
    @State private var selectedTab: Tabs = .home
    private var client: NetworkClient

    init(client: NetworkClient) {
        self.client = client
    }


    // MARK: - body
    var body: some View {
       tabview
    }

    @ViewBuilder
    var tabview: some View {
        TabView(selection: $selectedTab) {
            HomeCoordinator(client: client)
                .tabItem {
                    Image(systemName: "house")
                    Text("Home")
                }
            .tag(Tabs.home)

            Text("settings")
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
                .tag(Tabs.setting)
        }
        .tint(AppColor.appOrange.color)
    }
}

#Preview {
    MainTabCoordinator(client: NetworkClient())
}
