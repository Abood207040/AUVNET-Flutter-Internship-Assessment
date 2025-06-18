# AUVNET Internship Assessment

A Flutter e-commerce app built for the AUVNET internship assessment, following Clean Architecture principles and using the BLoC pattern for state management.

## Project Setup & Installation Guide

1. **Clone the repository:**
   ```bash
   git clone <your-repo-url>
   cd <repo-folder>
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Set up Firebase:**
   - Ensure you have a Firebase project and the correct configuration files (already included).
   - If needed, update `firebase_options.dart` using the FlutterFire CLI.
4. **Run the app:**
   ```bash
   flutter run
   ```

## Architectural Overview & Rationale

- **Clean Architecture:**
  - The project is organized into `data`, `domain`, and `presentation` layers for scalability and maintainability.
  - Data sources (Firebase, Hive) are abstracted from business logic.
- **State Management:**
  - Uses the BLoC pattern (`flutter_bloc`) for all stateful features.
  - Ensures immutability and consistent state updates using the `copyWith` approach.
- **Backend Integration:**
  - Firebase is used for authentication, Firestore for structured data, and Storage for file management.
- **Local Storage:**
  - Hive is used for caching user preferences and offline data.
- **UI/UX:**
  - Responsive, accessible, and intuitive design, supporting multiple devices and orientations.

## Features
- User authentication (sign up, login)
- Onboarding flow
- Home screen with navigation
- Local and remote data management

## Contact
For questions, contact: AhmedRoyale@AUVNET.com
