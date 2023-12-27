//
//  HideTabBar.swift
//  FarmFoster
//
//  Created by ebpearls on 26/12/2023.
//

import SwiftUI
import FlowStacks

struct HideTabBarOnPush<Screen: Equatable>: ViewModifier {
    @Binding var routes: Routes<Screen>

    func body(content: Content) -> some View {
        content
            .onChange(of: routes) { _ in
                if routes.count > 1 {
                    UITabBar.hideTabBar()
                }
            }
            .onAppear {
                UITabBar.showTabBar()
            }
    }
}
