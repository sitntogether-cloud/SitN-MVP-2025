# SitN MVP 2025

This is a SwiftUI project for SitN, a restaurant seating availability app.

## How to Run the Project Locally

To run this project, you will need Xcode installed on your Mac.

### Prerequisites

-   macOS
-   Xcode (latest version recommended)

### Opening the Project

1.  Clone the repository to your local machine.
2.  Open the `SitN.xcodeproj` file in Xcode.

### Running on the Simulator

1.  Once the project is open in Xcode, select a simulator from the target device dropdown menu at the top of the Xcode window (e.g., "iPhone 15 Pro").
2.  Click the "Run" button (the play icon) or press `Cmd+R`.
3.  Xcode will build the project and launch the selected simulator with the app running.

## Project Structure

### API Layer

The project includes a dedicated API layer for handling all network communication with a backend server. This layer is organized into several key components to ensure a clean and maintainable architecture:

-   **`API/APIService.swift`**: A singleton class responsible for making network requests (e.g., GET, POST). It encapsulates the logic for creating `URLRequest`s, using `URLSession`, and decoding JSON responses.
-   **`API/APIError.swift`**: A custom `Error` enum that defines specific networking errors, allowing for robust error handling throughout the app.
-   **`API/Endpoints.swift`**: An enum that defines all API endpoints in a structured way. This prevents typos and keeps all endpoint-related information (path, HTTP method, parameters) in one place.
-   **`API/Models/`**: This directory is intended to hold the `Codable` data models (DTOs) that directly map to the JSON responses from the API. This decouples the networking layer from the UI models.

The ViewModels in the `Features` directory would use the `APIService` to fetch and send data, providing a clear separation of concerns between the UI and the networking logic.
