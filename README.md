<<<<<<< HEAD
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
=======
# AUVNET-Flutter-Internship-Assessment
A simple, modern e-commerce app built with Flutter.  
Features onboarding, login, signup, home, sandwiches, and cart screens.  
Cart state is managed with BLoC and orders are saved to Firestore.

---

## Features

- **Splash Screen:** Animated logo and app name on launch.
- **Onboarding:** Three-page intro with large logo and simple text.
- **Login/Signup:** Clean, modern forms with logo, email, and password fields.
- **Home:** Browse sandwiches and other services.
- **Sandwiches:** List of sandwiches, add to cart with quantity dialog.
- **Cart:** View, update, and confirm your order. Orders are saved to Firestore.
- **BLoC:** Only the cart uses BLoC for state management.
- **Firestore:** Orders are securely saved to your Firestore database.

---

## Getting Started

### 1. Clone the repository

```bash
git clone <your-repo-url>
cd <your-repo-folder>
```

### 2. Install dependencies

```bash
flutter pub get
```

### 3. Add your Firebase configuration

- Follow the [FlutterFire documentation](https://firebase.flutter.dev/docs/overview/) to add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS).
- Make sure Firestore is enabled in your Firebase project.

### 4. Add assets

Ensure these images are present in `assets/images/` and referenced in `pubspec.yaml`:
- `nawel.png` (logo)
- `onboarding.png` (onboarding image)
- Any other images used in the app

### 5. Run the app

```bash
flutter run
```

---

## Firestore Security (Development)

For development, you can use open rules (not for production!):

```js
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

---

## Project Structure

- `lib/presentation/screens/` — All UI screens
- `lib/presentation/bloc/` — Cart BLoC
- `lib/data/` — Data sources and repositories
- `lib/domain/` — Domain models and entities

---

## Notes

- The UI is intentionally simple and clean.
- Only the cart uses BLoC for state management.
- All navigation is direct and straightforward.
- No advanced UI or unnecessary files.

---

## License

MIT 
>>>>>>> 8d4dda74f74b75d16aec4a21465c4bbff8a12164
