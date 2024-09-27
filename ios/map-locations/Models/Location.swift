//
//  Location.swift
//  map-locations
//
//  Created by Nic on 9/26/24.
//

import Foundation
import CoreLocation

enum LocationType: String, CaseIterable, Codable, Identifiable {
    
    case restaurant
    case museum
    case park
    case landmark
    case cafe
    case bar
    
    var id: String { self.rawValue.capitalized }
}

struct Attribute: Codable {
    
    let type: String
    let value: CodableValue
}

enum CodableValue: Codable {
    
    case string(String)
    case double(Double)
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let doubleVal = try? container.decode(Double.self) {
            self = .double(doubleVal)
        } else if let stringVal = try? container.decode(String.self) {
            self = .string(stringVal)
        } else {
            throw DecodingError.typeMismatch(CodableValue.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for CodableValue"))
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
            case .double(let doubleVal):
                try container.encode(doubleVal)
            case .string(let stringVal):
                try container.encode(stringVal)
        }
    }
}

struct Location: Codable, Identifiable {
    
    let id: Int
    let latitude: Double
    let longitude: Double
    let attributes: [Attribute]
    
        // Computed properties for easy access
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    var locationType: LocationType? {
        if let attribute = attributes.first(where: { $0.type == "location_type" }),
           case .string(let value) = attribute.value,
           let type = LocationType(rawValue: value) {
            return type
        }
        return nil
    }
    
    var name: String {
        if let attribute = attributes.first(where: { $0.type == "name" }),
           case .string(let value) = attribute.value {
            return value
        }
        return "Unknown"
    }
    
    var description: String {
        if let attribute = attributes.first(where: { $0.type == "description" }),
           case .string(let value) = attribute.value {
            return value
        }
        return "No description available."
    }
    
    var estimatedRevenue: Double? {
        if let attribute = attributes.first(where: { $0.type == "estimated_revenue_millions" }),
           case .double(let value) = attribute.value {
            return value
        }
        return nil
    }
}
