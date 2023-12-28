//
//  DiseaseModel.swift
//  FarmFoster
//
//  Created by ebpearls on 28/12/2023.
//

import SwiftUI

struct DiseaseModel: Hashable, Decodable {
    let id     : String
    let name     : String
    let symptoms :[String]
    let solution: [String]

    private enum CodingKeys: String, CodingKey {
            case id = "_id"
            case name
            case symptoms
            case solution
        }
}
