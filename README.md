# TaskFlow

A task management app built with Flutter, featuring a clean dashboard UI with sidebar navigation, task status tracking, and summary statistics.

## Features

- Dashboard with task overview and stats (total, in progress, completed)
- Task list with status badges (Todo / In Progress / Done)
- Check off tasks directly from the list
- Sidebar navigation (Home, My Tasks, Analytics, Settings)
- Material 3 design with deep purple theme
- Targets Android, iOS, Web, Windows, Linux, macOS

## Getting Started

```bash
flutter pub get       # Install dependencies
flutter run           # Run on connected device/emulator
flutter run -d chrome # Run in browser
flutter run -d windows # Run on Windows desktop
```

## Project Structure

```
lib/
  main.dart       # All app code: MyApp, HomePage, task widgets
```

## Building

```bash
flutter build apk      # Android
flutter build web      # Web
flutter build windows  # Windows
```

## Testing

```bash
flutter test           # Run all tests
flutter analyze        # Lint and static analysis
```