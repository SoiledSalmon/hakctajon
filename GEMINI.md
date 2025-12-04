# AI Loan Buddy - Project Context

## Project Overview
**AI Loan Buddy** is a premium, futuristic Flutter application designed to act as a personal loan advisor. It features a glassmorphic UI, AI chat capabilities, loan eligibility checking, and financial education modules.

## Tech Stack
- **Framework:** Flutter (Dart)
- **State Management:** Riverpod (`flutter_riverpod`)
- **Typography:** Google Fonts (`Poppins` for headings, `Inter` for body)
- **Animations:** Lottie, Flutter SVG
- **Icons:** Cupertino Icons

## Project Architecture

### Directory Structure (`lib/`)
- **`main.dart`**: Application entry point, `ProviderScope` setup, and `RouteGenerator` for named routing.
- **`models/`**: Data classes (e.g., `chat_message.dart`, `course.dart`).
- **`providers/`**: Riverpod providers managing application state (e.g., `chat_provider.dart` for chat logic).
- **`screens/`**: Full-page views (e.g., `home_screen.dart`, `chat_screen.dart`, `eligibility_screen.dart`).
- **`widgets/`**: Reusable UI components (e.g., `glass_card.dart`, `app_button.dart`).
- **`theme/`**: Design system configuration (`app_theme.dart`).
- **`utils/`**: Helper functions and constants (e.g., `navigation.dart`).

### Key Patterns & Conventions
- **State Management:** Uses `StateNotifierProvider` and `ConsumerWidget` from Riverpod.
- **Navigation:** Centralized named route handling in `RouteGenerator` class within `main.dart`.
- **Styling:** 
  - Supports Light and Dark modes via `AppTheme`.
  - Extensively uses **Glassmorphism** (translucent gradients, blurs).
  - Primary colors: Indigo/Purple variants.
- **Typography:** `Poppins` for headlines, `Inter` for body text.

## Development Workflow

### Prerequisites
- Flutter SDK: `>=2.17.0 <3.0.0` (Compatible with Flutter 3.x)
- Dart SDK

### Key Commands
- **Run App:** `flutter run`
- **Analyze Code:** `flutter analyze`
- **Run Tests:** `flutter test`
- **Format Code:** `dart format .`

## Important Files
- `lib/main.dart`: Routing and app initialization.
- `lib/theme/app_theme.dart`: Theme definitions and glassmorphic style constants.
- `lib/providers/chat_provider.dart`: Example of state management logic.
- `pubspec.yaml`: Dependencies and asset configurations.
