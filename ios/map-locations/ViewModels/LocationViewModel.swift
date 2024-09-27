//
//  LocationViewModel.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import Foundation
import Combine

class LocationViewModel: ObservableObject {
    
    @Published var locations: [Location] = []
    @Published var filteredLocations: [Location] = []
    @Published var selectedLocationType: LocationType? = nil
    
    private var cancellables = Set<AnyCancellable>()
    private let locationService: LocationServiceProtocol
    
        // Updated initializer
    init(locationService: LocationServiceProtocol = LocationService()) {
        self.locationService = locationService
        fetchLocations()
        setupBindings()
    }
    
    func fetchLocations() {
        Task {
            do {
                let locations = try await locationService.fetchLocations()
                DispatchQueue.main.async {
                    self.locations = locations
                    self.filteredLocations = locations
                }
            } catch {
                print("Error fetching locations: \(error)")
            }
        }
    }
    
    private func setupBindings() {
        $selectedLocationType
            .sink { [weak self] selectedType in
                guard let self = self else { return }
                if let type = selectedType {
                    self.filteredLocations = self.locations.filter {
                        $0.locationType == type
                    }
                } else {
                    self.filteredLocations = self.locations
                }
            }
            .store(in: &cancellables)
    }
}
