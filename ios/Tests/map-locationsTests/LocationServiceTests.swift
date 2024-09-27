//
//  LocationServiceTests.swift
//  map-locationsTests
//
//  Created by Nic on 9/26/24.
//

import XCTest
@testable import map_locations

class LocationServiceTests: XCTestCase {
    
    var locationService: LocationServiceProtocol!
    
    override func setUp() {
        super.setUp()
            // Use the mock service for testing
        locationService = MockLocationService()
    }
    
    override func tearDown() {
        locationService = nil
        super.tearDown()
    }
    
    func testFetchLocationsSuccess() async throws {
        let locations = try await locationService.fetchLocations()
        XCTAssertEqual(locations.count, 2, "Should fetch 2 mock locations")
    }
    
    func testFetchLocationsDataIntegrity1() async throws {
        let locations = try await locationService.fetchLocations()
        let firstLocation = locations.first
        XCTAssertEqual(firstLocation?.name, "Mock Restaurant", "First location should be 'Mock Restaurant'")
    }
    
    func testFetchLocationDataIntegrity2() async throws {
        let locations = try await locationService.fetchLocations()
        let secondLocation = locations[1]
        XCTAssertEqual(secondLocation.name, "Mock Cafe", "Second location should be 'Mock Cafe'")
    }
}
