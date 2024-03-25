//
//  LocalizedString.swift
//  FarmFoster
//
//  Created by ebpearls on 31/01/2024.
//

import Foundation

enum LocalizedString: String {
    case componentList
    case map
    case shader

    var key: String {
        NSLocalizedString(self.rawValue, comment: "")
    }
}
