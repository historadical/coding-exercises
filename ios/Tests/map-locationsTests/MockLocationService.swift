//
//  MockLocationService.swift
//  map-locations
//
//  Created by Nic on 9/27/24.
//

import Foundation
@testable import map_locations

class MockLocationService: LocationServiceProtocol {
    
    var mockLocations: [Location] = []
    
    init() {
        mockLocations = [
            Location(
                id: 1,
                latitude: 37.7749,
                longitude: -122.4194,
                attributes: [
                    Attribute(type: "location_type", value: .string("restaurant")),
                    Attribute(type: "name", value: .string("Mock Restaurant")),
                    Attribute(type: "description", value: .string("A test restaurant.")),
                    Attribute(type: "estimated_revenue_millions", value: .double(5.0))
                ]
            ),
            Location(
                id: 2,
                latitude: 37.7750,
                longitude: -122.4195,
                attributes: [
                    Attribute(type: "location_type", value: .string("cafe")),
                    Attribute(type: "name", value: .string("Mock Cafe")),
                    Attribute(type: "description", value: .string("A test cafe.")),
                    Attribute(type: "estimated_revenue_millions", value: .double(2.0))
                ]
            )
            // Add more mock locations as needed
        ]
    }
    
    func fetchLocations() async throws -> [Location] {
        return mockLocations
    }
}
