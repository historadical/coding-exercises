//
//  LocationViewModelTests.swift
//  map-locations
//
//  Created by Nic on 9/27/24.
//

import XCTest
import Combine
@testable import map_locations

class LocationViewModelTests: XCTestCase {
    
    var viewModel: LocationViewModel!
    var mockLocationService: MockLocationService!
    var cancellables: Set<AnyCancellable> = []
    
    override func setUp() {
        super.setUp()
        mockLocationService = MockLocationService()
        viewModel = LocationViewModel(locationService: mockLocationService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockLocationService = nil
        cancellables.removeAll()
        super.tearDown()
    }
    
    func testFetchLocations() {
        let expectation = XCTestExpectation(description: "Fetch locations")
        
        viewModel.fetchLocations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.locations.count, 2, "Should have fetched 2 mock locations")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFilteringLocations() {
        let expectation = XCTestExpectation(description: "Filter locations")
        
        viewModel.fetchLocations()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            XCTAssertEqual(self.viewModel.filteredLocations.count, 2, "Should have all locations when no filter is applied")
            
                // Filter by 'restaurant'
            self.viewModel.selectedLocationType = .restaurant
            XCTAssertEqual(self.viewModel.filteredLocations.count, 1, "Should have 1 location after filtering for 'restaurant'")
            XCTAssertEqual(self.viewModel.filteredLocations.first?.name, "Mock Restaurant", "Filtered location should be 'Mock Restaurant'")
            
                // Filter by 'cafe'
            self.viewModel.selectedLocationType = .cafe
            XCTAssertEqual(self.viewModel.filteredLocations.count, 1, "Should have 1 location after filtering for 'cafe'")
            XCTAssertEqual(self.viewModel.filteredLocations.first?.name, "Mock Cafe", "Filtered location should be 'Mock Cafe'")
            
                // Clear filter
            self.viewModel.selectedLocationType = nil
            XCTAssertEqual(self.viewModel.filteredLocations.count, 2, "Should have all locations when filter is cleared")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
