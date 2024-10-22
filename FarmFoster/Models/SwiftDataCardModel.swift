//
//  SwiftDataCardModel.swift
//  FarmFoster
//
//  Created by Roshan Chemjong on 02/05/2024.
//

import Foundation
import SwiftData

@Model
final class SwiftDataCardModel {
    var name: String
    var address: String
    
    init(name: String = "", address: String = "") {
        self.name = name
        self.address = address
    }
}
