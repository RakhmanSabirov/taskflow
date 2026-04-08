# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
flutter pub get          # Install dependencies
flutter run              # Run on connected device/emulator
flutter run -d chrome    # Run in Chrome (web)
flutter run -d windows   # Run on Windows
flutter test             # Run all tests
flutter test test/widget_test.dart  # Run a single test file
flutter analyze          # Lint and static analysis
flutter build apk        # Build Android APK
flutter build web        # Build web app
flutter build windows    # Build Windows app
```

## Architecture

This is a Flutter app targeting Android, iOS, Web, Windows, Linux, and macOS.

All application code lives in `lib/`. Currently a starter project with a single file (`lib/main.dart`) containing:

- **`MyApp`** — root `StatelessWidget`, configures `MaterialApp` with a deepPurple seed color theme
- **`MyHomePage`** — `StatefulWidget` that owns the page title
- **`_MyHomePageState`** — manages a counter with `setState()`

Linting rules come from `flutter_lints` via `analysis_options.yaml`. The Android build uses Gradle with Kotlin DSL (`android/build.gradle.kts`); Windows uses CMake (`windows/CMakeLists.txt`).
