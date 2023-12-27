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
    @State private var selectedTab: Tabs = .home
    var body: some View {
       tabview
    }

    @ViewBuilder
    var tabview: some View {
        TabView(selection: $selectedTab) {
          HomeCoordinator()
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
    MainTabCoordinator()
}
