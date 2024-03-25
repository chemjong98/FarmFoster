//
//  BuildConfiguration.swift
//  FarmFoster
//
//  Created by ebpearls on 19/03/2024.
//

import Foundation

enum BuildConfigurationKey: String {
    case graphURL = "GRAPH_URL"
}

struct BuildConfiguration {
    static func getValue<T>(key: BuildConfigurationKey) throws  -> T {
        guard let key = Bundle.main.object(forInfoDictionaryKey: key.rawValue) as? T else {
            throw AppError.custom("Cannot find the key: \(key.rawValue) in info.plist")
        }
        
        return key
    }
}
