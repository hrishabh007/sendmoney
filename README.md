# 💸 Send Money App

[![Flutter](https://img.shields.io/badge/Flutter-v3.x-blue)](https://flutter.dev)
[![BLoC](https://img.shields.io/badge/BLoC-State%20Management-green)](https://pub.dev/packages/flutter_bloc)
[![Tests](https://img.shields.io/badge/Tests-100%25%20Pass-brightgreen)](#)

A clean and lightweight **Flutter app** demonstrating a simple offline-first money transfer workflow.

This is a coding exercise that showcases:
- Clean Architecture (Presentation, Domain, Data)
- BLoC pattern for state management
- Unit and widget testing using `mocktail` and `flutter_test`

---

## 📱 App Features

- 💼 Wallet Page (Balance Display, Hide/Show toggle)
- 💸 Send Money Page (Amount input with success/error bottom sheet)
- 📃 Transactions Page (Transaction history with loading/error states)

---

## 🏗️ Folder Structure

lib/
├── core/
├── features/
│   └── wallet/
│       ├── data/
│       ├── domain/
│       └── presentation/
│           ├── bloc/
│           ├── pages/
│           └── widgets/
├── main.dart

test/
└── widget_test.dart


---

## 🚀 Getting Started

### ✅ Prerequisites

- Flutter SDK (v3.10+ recommended)
- Dart (comes with Flutter)
- Android Studio / VS Code or any IDE of your choice

### 🔧 Installation

```bash
git clone https://github.com/rishabh-balani/send-money-app.git
cd send-money-app
flutter pub get
flutter run

##  Running Tests
flutter test

🙋‍♂️ Author

Made with ❤️ by Rishabh Balani
