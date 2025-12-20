# LevPay Mobile

A production-ready Flutter mobile application for the LevPay platform, built with Clean Architecture.

## Project Structure

This project follows a **Feature-First Clean Architecture** approach:

```
lib/
├── core/                # Shared utilities, network, storage across app
├── features/            # Feature modules (Auth, Wallet, etc.)
│   ├── data/            # Repositories impl, datasources, models
│   ├── domain/          # Entities, usecases, repository interfaces
│   └── presentation/    # Screens, widgets, Riverpod providers
├── shared/              # Shared UI components
└── config/              # Routes, environment, themes
```

## Getting Started

### Prerequisites

- Flutter SDK (3.10.x or higher)
- Android Studio / VS Code with Flutter extensions

### Setup

1. **Install Dependencies**
   ```bash
   flutter pub get
   ```

2. **Generate Code** (required for Riverpod, Freezed, JSON serialization)
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```
   *Tip: Run this whenever you change models or providers.*

3. **Run the App**
   ```bash
   flutter run
   ```

## Key Technologies

- **State Management**: Riverpod (with code generation)
- **Navigation**: GoRouter
- **Network**: Dio + Retrofit
- **Local Storage**: Flutter Secure Storage & Hive
- **Models**: Freezed (Immutable)
- **Forms**: Flutter Form Builder

## Development Workflow

1. Create a new feature folder in `lib/features/`
2. Define the **Domain** layer (Entities & UseCases)
3. Implement the **Data** layer (Models & Repositories)
4. Build the **Presentation** layer (Providers & Screens)
