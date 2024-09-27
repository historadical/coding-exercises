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
        ScrollView {
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
                
                    // Display other attributes if needed
                ForEach(location.attributes, id: \.type) { attribute in
                    if attribute.type != "name" && attribute.type != "description" && attribute.type != "estimated_revenue_millions" && attribute.type != "location_type" {
                        if case .string(let value) = attribute.value {
                            Text("\(attribute.type.capitalized): \(value)")
                        } else if case .double(let value) = attribute.value {
                            Text("\(attribute.type.capitalized): \(value)")
                        }
                    }
                }
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle(location.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}
