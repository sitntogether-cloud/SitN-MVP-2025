# SitN MVP 2025

This is a SwiftUI project for SitN.

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

## Project Status & Next Steps as of 11/1/25

This section outlines the current state of the SitN mobile application and a strategic path forward for its continued development, feature enhancement, and eventual launch on the Apple App Store.

### Current State of the Application

We have developed a good starting point for the SitN app using SwiftUI. The application has a clean, feature-driven architecture (inspired by MVVM) with a solid foundation for future expansion.

The current MVP includes the following core features with mocked data and functionality:
*   **User Authentication:** A complete, multi-step user onboarding and login flow.
*   **Core User Flow:** An intuitive process for users to select a cuisine, choose a restaurant, pick a reservation time, and invite other users.
*   **Profile & Settings:** Screens for users to view and edit their profile information and manage app settings.
*   **Abstracted UI:** Commonly used components, such as buttons and cards, have been abstracted for consistency and reusability.

The app currently uses mock data, which allows for rapid UI/UX iteration. The next major phase will be to build out the backend and connect the app to a live API.

### How to Add Features

The project is structured to make feature development straightforward, whether you're using AI assistance or traditional methods.

**With AI Assistance:**
You can simply provide a high-level requirement. The AI can understand the project's structure and conventions to generate new views, view models, and services, and then integrate them into the existing codebase.

*Example prompt:* "Add a map view to the restaurant selection screen that displays pins for each restaurant."

**Manual Development:**
A developer can follow the established patterns in the codebase:
1.  Create a new folder under `Features` for the new feature.
2.  Develop the necessary SwiftUI Views, ViewModels, and Models.
3.  For features requiring backend data, the ViewModel will eventually call the `APIService`.
4.  Integrate the new view into the app's navigation flow, which is managed in the parent views or the root `SitNApp.swift` file.

### Path to Production & Next Steps

Here is a high-level roadmap to take the app from its current MVP state to a production-ready application on the App Store:

1.  **Phase 1: Backend Development:** This is the most critical next step. We need to build a robust backend API and replace all mock data in the app with live network calls using the `APIService` layer.
2.  **Phase 2: Feature Enhancement:** Implement key UX improvements such as a map view for restaurants, real-time chat for invites, and more detailed user profiles.
3.  **Phase 3: Comprehensive Testing:**
    *   Write unit tests for ViewModels and business logic.
    *   Develop UI tests for critical user flows like onboarding and the reservation process.
    *   Conduct beta testing with a select group of users via TestFlight to gather feedback and identify bugs.
4.  **Phase 4: App Store Submission:** Prepare all necessary App Store assets (screenshots, icons, descriptions), configure the app in App Store Connect, and submit for review.

### Production-Level Requirements

To be considered a production-level app, the following requirements must be met:
*   **Scalable & Secure Backend:** The backend must be able to handle a growing number of users and protect their data.
*   **Real-time Functionality:** If wanted/required, a real-time messaging service (e.g., WebSockets) is essential for the invite and matching features.
*   **Persistent & Secure Database:** All user and application data must be stored securely.
*   **Robust Error Handling:** The app must gracefully handle all potential errors, including network failures and server-side issues.
*   **Analytics & Crash Reporting:** Integration of tools like Firebase, Sentry, or Datadog is crucial for monitoring app health and user behavior.
*   **CI/CD Pipeline:** An automated build, test, and deployment pipeline will be necessary for efficient and reliable updates.

### Backend Recommendations

**Technologies:**
*   **Framework:** **Node.js with NestJS** is an excellent choice for its scalability and strong support for real-time applications. Alternatively, **Python with FastAPI** offers rapid development, and **Server-Side Swift with Vapor** would allow for a unified language across the stack.
*   **Database:** **PostgreSQL** is a powerful and reliable relational database suitable for most needs. For more flexibility with user profiles, a NoSQL database like **MongoDB** or a managed service like **Firebase Firestore** (which has excellent real-time capabilities) would be a great fit.

**Hosting Solutions:**
*   **Backend as a Service (BaaS):** For speed and efficiency, **Supabase**, **Firebase** or **AWS Amplify** are highly recommended. They provide pre-built, scalable solutions for authentication, databases, and storage, which would significantly accelerate backend development.
*   **Cloud Providers:** For more control, deploying on **Supabase**, **AWS**, **Google Cloud Platform (GCP)**, or **Azure** is the standard. This gives you access to a vast array of services that can scale with the app.

**High-Level Backend Responsibilities:**
*   **Authentication & Authorization:** Securely manage user accounts, sessions (e.g., using JWTs), and permissions.
*   **User & Profile Management:** Full CRUD (Create, Read, Update, Delete) operations for all user data.
*   **Restaurant & Reservation Data:** Manage restaurant details, seating availability, and time slots.
*   **Matching Algorithm:** The core logic that connects users who have selected the same restaurant and time. This will likely be an event-driven system that processes user selections in real-time.
*   **Invite & Notification System:** A real-time service to handle sending invites and push notifications (via APNs) to users' devices.
*   **Logging & Monitoring:** Comprehensive logging of API requests, errors, and performance metrics.
