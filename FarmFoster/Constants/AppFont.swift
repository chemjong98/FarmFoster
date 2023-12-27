//
//  AppFont.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

enum AppFont {
    case regular
    case bold

    var font: String {
        switch self {
        case .regular:
            return "Roboto-Regular"
        case .bold:
            return "Roboto-Bold"
        }
    }
}
