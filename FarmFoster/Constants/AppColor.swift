//
//  AppColor.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

enum AppColor: String {
    case bg
    case appGray
    case appOrange
    case navyBlue

    var color: Color {
        Color(self.rawValue)
    }
}
