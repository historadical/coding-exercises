//
//  ContentView.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = LocationViewModel()
    
    var body: some View {
        VStack {
                // Filtering Control
            Picker("Location Type", selection: $viewModel.selectedLocationType) {
                Text("All").tag(LocationType?.none)
                ForEach(LocationType.allCases) { type in
                    Text(type.rawValue.capitalized).tag(type as LocationType?)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
                // Map View
            MapView(locations: viewModel.filteredLocations)
                .edgesIgnoringSafeArea(.all)
        }
    }
}
