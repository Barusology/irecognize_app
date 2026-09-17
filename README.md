# iRecognize

<div align="center">

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart)
![Material%203](https://img.shields.io/badge/Design-Material%203-5C6BC0?style=for-the-badge)
![Status](https://img.shields.io/badge/Status-Prototype-34A853?style=for-the-badge)

</div>

iRecognize is a Flutter-based visual discovery and identification app designed for exploring plants, architecture, artifacts, and cultural objects through camera-first interaction and an archival browsing experience. The project combines a premium editorial interface with a structured archive workflow intended for research, field observation, and learning.

## Overview

At its core, iRecognize is built around a simple idea: users capture or browse an object, explore contextual metadata, and evaluate likely matches through a guided visual interface. The app architecture separates presentation, data access, and domain models to provide a clean foundation for future AI-powered identification services and real backend integrations.

## Key Features

- Camera-first identification experience with targeting reticle overlays
- Archive browsing and collection organization for saved entries
- Geographic map-based discovery flow for location-aware exploration
- Material 3-based visual identity with editorial, museum-like styling
- Structured sample data model for future integration with live repositories or APIs
- Clean separation of UI, data, and application styling for maintainability

## Screens and Experience

- Camera identification screen
- Research collection archive screen
- Geographic archive map screen
- Detail view for recorded objects
- History and settings placeholder areas for future feature expansion

## Tech Stack

- Flutter
- Dart
- Material 3
- Device Preview (development preview)
- Google Fonts
- Material Symbols Icons

## Project Structure

```text
.
├── android/                 # Android project files
├── ios/                     # iOS project files
├── lib/
│   ├── core/                # theme, logging, shared configuration
│   ├── data/                # repository and mock data access
│   ├── models/              # domain models
│   ├── screens/             # UI screens and navigation
│   ├── main.dart            # App entry point
│   └── ...
├── test/                    # automated tests
├── web/                     # web platform support
├── windows/                 # Windows support
├── linux/                   # Linux support
├── macos/                   # macOS support
├── pubspec.yaml             # Flutter project configuration
├── analysis_options.yaml    # linting configuration
├── CHANGELOG.md             # release notes
├── CONTRIBUTING.md          # contribution guide
├── README.md                # project overview
├── .gitignore
└── ...
```

## Getting Started

### Prerequisites

Make sure you have the following installed:

- Flutter SDK 3.12 or newer
- Dart SDK
- Android Studio or VS Code with Flutter tooling
- An emulator or physical device for local testing

### Installation

```bash
git clone https://github.com/Barusology/irecognize_app.git
cd irecognize_app
flutter pub get
```

### Run the app

```bash
flutter run
```

For a specific device:

```bash
flutter devices
flutter run -d <device-id>
```

## Validation

### Run tests

```bash
flutter test
```

### Lint and analyze

```bash
flutter analyze
```

## Product Direction

This project is currently positioned as a design-led prototype and extensible foundation for broader recognition workflows. It is structured to support future expansion into:

- live object recognition APIs
- user-authenticated research archives
- cloud-based catalog synchronization
- advanced AI matching and confidence scoring
- enterprise or education-focused deployments

## Contributing

We welcome contributions that improve product quality, app architecture, UX, and testing. Please read [CONTRIBUTING.md](CONTRIBUTING.md) before proposing changes.

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for the latest project updates and milestones.

## License

This project is intended for development, experimentation, and further product iteration. Please review repository policies and licensing terms before commercial deployment or redistribution.

## Repository

- GitHub: https://github.com/Barusology/irecognize_app
