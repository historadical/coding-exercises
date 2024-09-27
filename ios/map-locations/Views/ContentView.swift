//
//  ContentView.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = LocationViewModel()
    @State private var selectedLocation: Location? = nil
    
    var body: some View {
        VStack {
                // Filtering Control
            HStack {
                Text("Filter by Type: \(viewModel.selectedLocationType?.rawValue.capitalized ?? "All")")
                    .font(.headline)
                Spacer()
                Menu {
                    Button("All") {
                        viewModel.selectedLocationType = nil
                    }
                    ForEach(LocationType.allCases) { type in
                        Button(type.rawValue.capitalized) {
                            viewModel.selectedLocationType = type
                        }
                    }
                } label: {
                    Label("Select", systemImage: "line.horizontal.3.decrease.circle")
                }
            }
            .padding()
            
                // Map View
            MapView(locations: $viewModel.filteredLocations, selectedLocation: $selectedLocation)
                .edgesIgnoringSafeArea(.all)
                .sheet(item: $selectedLocation) { location in
                    LocationDetailView(location: location)
                }
        }
    }
}
