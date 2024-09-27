//
//  LocationService.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import Foundation

protocol LocationServiceProtocol {
    func fetchLocations() async throws -> [Location]
}

class LocationService: LocationServiceProtocol {
    
    func fetchLocations() async throws -> [Location] {
        guard let url = URL(string: Constants.locationsDataURLString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        let locations = try decoder.decode([Location].self, from: data)
        return locations
    }
}
