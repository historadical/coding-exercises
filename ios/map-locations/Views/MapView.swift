//
//  MapView.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import SwiftUI
import MapKit

struct MapView: View {
    
    @Binding var locations: [Location]
    @Binding var selectedLocation: Location?
    
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    var body: some View {
        Map(coordinateRegion: $region, annotationItems: locations) { location in
            MapAnnotation(coordinate: location.coordinate) {
                Button(action: {
                    selectedLocation = location
                }) {
                    Image(systemName: "mappin.circle.fill")
                        .foregroundColor(location.locationType?.color ?? .red)
                        .font(.title)
                }
                .accessibilityLabel(location.name)
                .accessibilityHint("Tap to view details")
            }
        }
    }
}
