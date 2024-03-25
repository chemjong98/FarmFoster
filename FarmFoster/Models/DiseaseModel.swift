//
//  DiseaseModel.swift
//  FarmFoster
//
//  Created by ebpearls on 28/12/2023.
//

import SwiftUI

struct DiseaseModel: Hashable, Decodable {
    let name     : String
    let symptoms :[String]
    let solution: [String]

}

struct ItemDiseaseModel: Hashable, Decodable {
    let id : String
    let itemName : String
    let itemDisease: [DiseaseModel]

    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case itemName
        case itemDisease
    }
}
