//
//  DetailCalloutContentView.swift
//  map-locations
//
//  Created by Nic on 9/27/24.
//

import SwiftUI

struct DetailCalloutContentView: View {
    
    let location: Location
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(location.description)
                .font(.subheadline)
            if let revenue = location.estimatedRevenue {
                Text("Estimated Revenue: $\(revenue, specifier: "%.1f") million")
                    .font(.footnote)
            }
            if let type = location.locationType?.rawValue {
                Text("Location Type: \(type.capitalized)")
                    .font(.footnote)
            }
                // Display other attributes if needed
            ForEach(location.attributes, id: \.type) { attribute in
                if attribute.type != "name" && attribute.type != "description" && attribute.type != "estimated_revenue_millions" && attribute.type != "location_type" {
                    if case .string(let value) = attribute.value {
                        Text("\(attribute.type.capitalized): \(value)")
                            .font(.footnote)
                    } else if case .double(let value) = attribute.value {
                        Text("\(attribute.type.capitalized): \(value)")
                            .font(.footnote)
                    }
                }
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(8)
    }
}
