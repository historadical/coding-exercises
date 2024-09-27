//
//  MapView.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    
    let locations: [Location]
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        let centerCoordinate = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194)
        let region = MKCoordinateRegion(center: centerCoordinate, span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
        mapView.setRegion(region, animated: false)
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.removeAnnotations(uiView.annotations)
        
        let annotations = locations.map { location -> CustomAnnotation in
            let annotation = CustomAnnotation(location: location)
            return annotation
        }
        
        uiView.addAnnotations(annotations)
    }
    
    class Coordinator: NSObject, MKMapViewDelegate {
        var parent: MapView
        
        init(_ parent: MapView) {
            self.parent = parent
        }
        
            // Handle annotation view
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let customAnnotation = annotation as? CustomAnnotation else { return nil }
            
            let identifier = "CustomAnnotationView"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
            
            if annotationView == nil {
                annotationView = MKMarkerAnnotationView(annotation: customAnnotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = true
            } else {
                annotationView?.annotation = customAnnotation
            }
            
                // Update the detail callout view
            let detailView = DetailCalloutView(location: customAnnotation.location)
            annotationView?.detailCalloutAccessoryView = detailView
            
                // Update the marker tint color based on location type
            if let type = customAnnotation.location.locationType {
                annotationView?.markerTintColor = UIColor(type.color)
            } else {
                annotationView?.markerTintColor = UIColor.red // Default color
            }
            
            return annotationView
        }
    }
}
