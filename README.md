# LevPay Mobile 📱

![Flutter](https://img.shields.io/badge/Flash-Flutter-%2302569B.svg?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=ios&logoColor=white)

**LevPay Mobile** is the native mobile experience for the LevPay platform. Engineered with **Flutter** and strictly following **Clean Architecture** principles, it delivers a high-performance, maintainable, and visually stunning experience on both Android and iOS.

## ✨ Key Features

-   **Secure Authentication**: Biometric-ready login flow with secure token storage.
-   **Feature-Rich Wallet**: Real-time balance updates, transaction history, and detailed receipt views.
-   **Send Money**: Intuitive multi-step transfer flow with user search.
-   **Mobile KYC**: Camera integration for document capture and identity verification.
-   **Admin Mode**: Dedicated mobile dashboard for administrators to monitor platform health on the go.
-   **Notifications**: Integrated notification center for transactional and system alerts.

## 🛠️ Tech Stack

-   **Framework**: Flutter 3.x
-   **Architecture**: Clean Architecture (Feature-first)
-   **State Management**: `flutter_bloc`
-   **DI**: `get_it` & `injectable` (or Provider/RepositoryProvider pattern)
-   **Routing**: `go_router`
-   **Networking**: `dio` (with interceptors for Auth)
-   **Storage**: `flutter_secure_storage`

## 🚀 Getting Started

### Prerequisites

-   Flutter SDK installed
-   Android Studio / VS Code with Flutter/Dart plugins
-   Android Emulator or Physical Device

### Installation

1.  **Get Dependencies**:
    ```bash
    flutter pub get
    ```

2.  **Code Generation** (for JSON serialization/freezed):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```

3.  **Run Application**:
    ```bash
    flutter run
    ```

## 📂 Architecture Overview

We use a layered architecture decoupled by dependency injection:

```
lib/
├── core/                   # Core functionality (Network, Theme, Router)
├── features/               # Feature Modules
│   ├── auth/               # Login, Register
│   ├── wallet/             # Balance, Transactions
│   ├── admin/              # Admin Dashboard
│   │   ├── data/           # Repositories & DTOs
│   │   ├── domain/         # Entities & UseCases
│   │   └── presentation/   # BLoCs & UI Screens
│   └── ...
└── main.dart               # Entry Point & App Configuration
```

## 🎨 Theme & UI

LevPay Mobile follows a custom design system defined in `core/theme/`:
-   **Colors**: Custom palette (`AppColors.deepTeal`, `mintGreen`)
-   **Typography**: Optimized for mobile readability
-   **Components**: Reusable widgets in `shared/`

## 🤝 Contributing

Contributions are welcome! Please ensure you run `flutter format .` before submitting your PR.
