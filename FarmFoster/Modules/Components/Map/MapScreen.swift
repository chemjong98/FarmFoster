//
//  MapScreen.swift
//  FarmFoster
//
//  Created by ebpearls on 30/01/2024.
//

import SwiftUI
import MapKit

struct MapScreen: View {
    // MARK: - properties
    private var location = CLLocationCoordinate2D(latitude: 51.483890553046415, longitude: -0.6043978877913696)
    @State var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 51.483890553046415, longitude: -0.6043978877913696), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))

    // MARK: - init
    init() {
        let map = MKMapView.appearance()

        map.mapType = .hybrid
//        map.showsTraffic = false
//        map.showsBuildings = true
//        map.showsScale = true
        map.isRotateEnabled = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true

        let annotation = MKPointAnnotation()
        annotation.title = "windsor castle"
        annotation.coordinate = location // Set a valid coordinate
        map.addAnnotation(annotation)
        }

    // MARK: - body
    var body: some View {
        Map(coordinateRegion: $mapRegion)
    }
}

#Preview {
    MapScreen()
}
