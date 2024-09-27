# Take-Home Coding Exercise

Welcome to the coding exercise! The goal of this project is to demonstrate your skills by building an app that displays a set of locations on a map in a performant manner. Please follow the instructions below to complete the exercise.

## Project Overview

This exercise involves fetching data from a JSON file stored in this repository and implementing a map view to display locations. You'll need to implement features like filtering locations by type and displaying additional information when a location is tapped.

## Instructions

1. **Fork the Repository:**
    - Please begin by forking this repository.
    - All of your changes should be committed to your fork.
    - Optional: Use pull requests with short descriptions to help explain as you go through

2. **Setup Project:**
    - Create an `android` or `ios` folder respectively in the root of this folder. This is where your project will live.

3. **Fetch Location Data:**
    - The repository contains a JSON file, `locations.json`, that lists various locations.
    - Use the raw file content feature of GitHub for fetching data (think of it as a mock API). Please point it to your forked repository, not the Voze repository.
        - `https://raw.githubusercontent.com/<GITHUB_ACCOUNT_NAME>/coding-exercises/master/mobile/map-locations/locations.json`
    - Your task is to parse this file and use the data within the app.

4. **Display Locations on a Map View:**
    - Create a map view in the app as the main view.
        - The data is centered around San Francisco. Please set the default location to there.
    - Plot the locations from the JSON file on the map using pins or markers.

5. **Filtering Locations:**
    - Implement a way to filter the displayed locations by `location_type`.
        - The assumption can be made the location_types are a static set and will not change.
        - You can provide a UI (e.g., dropdown menu, segmented control, etc) that allows users to select which types of locations to display on the map.
        - Please feel free to "steal" existing UI from other application such as Google Maps, Apple Maps, Zillow, etc for filtering or craft your own.
        - Optional: Distinguish between location types through the presentation of pin or markers.

6. **Additional Details on Tap:**
   - When a user taps on a location pin, show a view with more detailed information about that location.
        - Display all `attributes` inside this detail view.
        - Please feel free to "steal" existing UI from other application such as Google Maps, Apple Maps, Zillow, etc for details or craft your own.

## Requirements

- **Documentation:**
    - Please add any contextual implementation information into Implementation section at the bottom of this `README`.
    - Add code comments when relevant
    - Add information on how to get the application up and running into the Getting Started section at the bottom of this `README`.
- **Programming Language:**
    - iOS: Please focus on using Swift
    - Android: Please focus on using Kotlin (Java is still acceptable, however Kotlin is preferred)
- **Data Fetching:**
    - You may use the std library or a 3rd party library for making HTTP request.
        - If using a 3rd party library please explain why inside the Implementation section at the bottom of this `README`.
- **Map Integration:**
    - You may use any mapping library, such as MapKit
    - Please do not use a mapping library which requires an API key
- **UI/UX:**
    - Design a user-friendly interface to interact with the map and filter locations.
    - Keep it simple. This isn't a exercise to test your design skill.
- **Filtering:**
    - Implement efficient filtering of locations by their type.

## Submission

1. Once you have completed the exercise email a link to the forked repository.

## Evaluation Criteria

- **Correctness:** Does the app fetch and display data correctly?
- **UI/UX:** Is the map view intuitive and easy to use (within reason given lack of design criteria)?
- **Code Quality:** Is the code clean, readable, follow modern architecture per environment, and well-structured?
- **Filtering:** Is filtering by location type implemented efficiently?
- **Attention to Detail:** Does the app show detailed information when a pin is tapped?

Feel free to reach out if you have any questions. Good luck, and happy coding!

Do not edit any lines above this line break.

---

# Getting Started

Welcome to the **San Francisco Locations Map App**! This application displays a set of locations on a map centered around San Francisco. It allows users to filter locations by type and view detailed information about each location directly from the map. The app is built with **SwiftUI**, follows the **MVVM** architecture, and includes unit tests to ensure code reliability.

## Prerequisites

- **Xcode 16** or later
- **Swift 5.5** or later
- **iOS 16** or later (deployment target)

## Setup Instructions

1. **Clone or Download the Project**:

   - Clone the repository from GitHub or download the project ZIP file and extract it to your desired location.

2. **Open the Project in Xcode**:

   - Navigate to the project folder and open the `.xcodeproj` file with Xcode.

3. **Build and Run the App**:

   - Select the desired simulator or connect your physical device.
   - Click on **Product** > **Run** or press **⌘R**.
   - The app should launch, displaying the map centered on San Francisco.

## Usage

- **Filtering Locations**:

  - At the top of the screen, you'll see a label indicating the current filter (e.g., **"Filter by Type: All"**).
  - Tap on the **"Select"** button (with the filter icon) to open the filter menu.
  - Choose a location type (e.g., **"Restaurant"**) to filter the map pins to that type.
  - To show all locations again, select **"All"** from the filter menu.

- **Viewing Location Details**:

  - Tap on any map pin to display a small popup (callout) with detailed information about the location.
  - The callout includes the name, description, estimated revenue, location type, and any additional attributes.

- **Interacting with the Map**:

  - You can zoom in and out using pinch gestures.
  - Pan around the map by dragging with one finger.

- **Running Unit Tests**:

  - The project includes unit tests to verify the functionality of the models and view models.
  - To run the tests:
    - Select the **Test** scheme in Xcode.
    - Click on **Product** > **Test** or press **⌘U**.
    - Review the test results in the **Test Navigator**.

---

# Implementation

The application is built using **SwiftUI** and follows the **MVVM (Model-View-ViewModel)** architectural pattern. It includes unit tests to ensure code reliability and correctness. Below is an overview of the key components and how they work together.

## Data Models

### `LocationType`

- Defines an `enum` for the different types of locations (e.g., restaurant, museum).
- Conforms to `CaseIterable`, `Codable`, and `Identifiable` protocols.
- Includes a computed property `color` to assign a specific color to each location type.

### `Attribute`

- Defines a struct `Attribute` representing each attribute of a location.
- Uses an `enum` `CodableValue` to handle different types of attribute values (`String` or `Double`).

### `Location`

- Represents a location with properties for `id`, `latitude`, `longitude`, and `attributes`.
- Includes computed properties for easy access to common attributes like `name`, `description`, `locationType`, and `estimatedRevenue`.

## ViewModel

### `LocationViewModel.swift`

- Manages the state and business logic of the app.
- Fetches location data asynchronously using `async/await`.
- Handles filtering of locations based on the selected `locationType`.
- Publishes changes to the views through `@Published` properties.

## Services

### `LocationService.swift`

- Responsible for fetching location data from the locations data hosted on GitHub.
- Utilizes Swift's `async/await` for asynchronous data fetching.

## Views

### `ContentView.swift`

- The main view of the app.
- Contains the filter menu and integrates the `MapView`.
- Uses a `VStack` to layout the filter control and map.
- Observes the `LocationViewModel` for data and state changes.

### `MapView.swift`

- Wraps `MKMapView` using `UIViewRepresentable` to integrate with SwiftUI.
- Displays custom annotations (`CustomAnnotation`) on the map.
- Implements `MKMapViewDelegate` methods to manage annotations and callouts.
- Handles updates to annotations when filtering to ensure correct data display.

### `CustomAnnotation.swift`

- Defines a custom annotation class that conforms to `MKAnnotation`.
- Associates each annotation with a `Location` object.
- Provides properties for `coordinate`, `title`, and `subtitle`.

### `DetailCalloutView.swift`

- A `UIView` that hosts a SwiftUI view (`DetailCalloutContentView`) to display in the annotation's callout.
- Manages the layout and sizing of the callout content.
- Overrides `intrinsicContentSize` to ensure proper sizing.

### `DetailCalloutContentView.swift`

- A SwiftUI view that displays detailed information about a location.
- Includes all attributes such as name, description, estimated revenue, location type, and any additional attributes.

## Unit Tests

### `LocationTests.swift`

- Contains unit tests for the `Location` model.
- Verifies that computed properties correctly extract attributes from the JSON data.
- Tests parsing of different attribute types.

### `LocationViewModelTests.swift`

- Tests the `LocationViewModel`'s ability to fetch and filter locations.
- Mocks the `LocationService` to provide controlled data for testing.
- Verifies that filtering logic works as expected.

## Filtering Functionality

- The app provides a filtering menu using `Menu` and `Button`.
- Users can select a `locationType` to filter the displayed locations.
- The label next to the filter menu dynamically updates to show the currently selected filter.

## Handling Annotation Updates

- When filtering, the app updates the annotations displayed on the map.
- Ensures that reused `MKAnnotationView`s are correctly updated with new data.
- The `mapView(_:viewFor:)` delegate method updates the `detailCalloutAccessoryView` and `markerTintColor` every time, whether the annotation view is newly created or reused.

## Accessibility

- The app includes descriptive labels and hints for interactive elements.
- Map annotations are accessible, providing information to users with assistive technologies.

## Performance Considerations

- Uses efficient data fetching with `async/await`.
- Manages annotation views to prevent stale data and ensure smooth performance.
- Avoids overloading the map with unnecessary annotations by filtering data effectively.

## Code Quality

- Follows modern iOS coding standards and best practices.
- Utilizes Swift's strong type system and optionals for safety.
- Code is clean, readable, and well-structured.
- Includes code comments where relevant for better understanding.
