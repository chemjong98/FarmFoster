//
//  AppImage.swift
//  FarmFoster
//
//  Created by ebpearls on 20/12/2023.
//

import SwiftUI

enum AppImage: String {
    case homeImg
    case logo
    case blueBerry
    case blueBerry2
    case horse

    var image: Image {
        Image(self.rawValue)
    }
}
