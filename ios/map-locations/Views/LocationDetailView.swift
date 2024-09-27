//
//  LocationDetailView.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import SwiftUI

struct LocationDetailView: View {
    
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(location.name)
                .font(.title)
                .bold()
            
            Text(location.description)
                .font(.body)
            
            if let revenue = location.estimatedRevenue {
                Text("Estimated Revenue: $\(revenue, specifier: "%.1f") million")
                    .font(.subheadline)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
