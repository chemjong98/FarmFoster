//
//  FarmFosterApp.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI
import FlowStacks
import SwiftData

@main
struct FarmFosterApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 17.0, *) {
                AppCoordinator()
                    .modelContainer(for: SwiftDataCardModel.self)
            } else {
                AppCoordinator()
            }
        }
    }
}
