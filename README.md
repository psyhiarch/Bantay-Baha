# Bantay-Baha

A real-time flood monitoring app built with Flutter and MapLibre. It pulls live flood station data from the Bahaba API, displays station markers on a map, and lets users inspect rainfall, water level, and risk categories for each station.

## Overview

Bantay-Baha is designed for quick situational awareness during flood events. The app shows:

- live flood station locations on a map
- station risk levels (`NORMAL`, `WARNING`, `ALARM`, `CRITICAL`)
- rainfall data for 10-minute, 1-hour, and 24-hour windows
- water level and 1-hour change
- a bottom sheet with detailed station metrics
- auto-refresh and manual refresh support

## Features

- Real-time flood monitoring using the Bahaba API
- Interactive map with MapLibre GL
- Animated pulse markers for flood stations
- Risk-based color coding for each station
- Tap a station to view detailed readings
- Auto-refresh every 5 minutes
- Fresh data loaded from the live endpoint

## Tech stack

- Flutter
- Dart
- MapLibre GL for map rendering
- HTTP for API requests

## Project structure

```text
.
├── lib/
│   ├── main.dart
│   └── ui/
│       └── views/
│           └── home/
│               └── home_view.dart
├── test/
│   └── widget_test.dart
├── android/
├── ios/
├── linux/
├── macos/
├── windows/
├── web/
├── analysis_options.yaml
├── pubspec.yaml
├── README.md
└── .metadata
```

## Important implementation notes

The current project follows a simple UI-first architecture for a small app:

- `main.dart` starts the app and initializes MapLibre pre-warming
- `lib/ui/views/home/home_view.dart` contains the main flood-monitoring view
- the screen is responsible for:
  - fetching station data
  - parsing the API response
  - converting data to GeoJSON
  - creating map layers
  - animating pulse markers
  - showing station details in a bottom sheet

This is a practical prototype architecture, and it can be refactored into a cleaner layered structure later if the project grows.

## API source

The app uses the live flood station API:

```text
https://bahaba.nicolei.games/api/flood/live
```

The app validates the response shape and filters out invalid coordinates before plotting markers.

## Getting started

### Prerequisites

- Flutter SDK
- Android Studio / Xcode / VS Code depending on platform

### Install dependencies

```bash
flutter pub get
```

### Run the app

```bash
flutter run
```

### Run tests

```bash
flutter test
```

## Environment

The project currently targets the Flutter SDK version declared in `pubspec.yaml`:

```yaml
environment:
  sdk: ^3.13.4
```

## Roadmap

- [x] Display flood stations from the API
- [x] Parse and validate live readings
- [x] Auto-refresh on interval
- [x] Show map-based station markers
- [x] Show station detail sheet
- [ ] Refactor into a cleaner architecture
- [ ] Add a telemetry dashboard
- [ ] Add geocoding/search for places
- [ ] Add production-grade tests for the monitoring flow

## Credits

This project is based on data from the Bahaba flood API and was inspired by the work of the Bahaba project by [haliknihudas666](https://github.com/haliknihudas666).

## License

This project does not currently declare a license in the repository metadata.

## Notes

Bantay-Baha is a practical flood monitoring prototype focused on real-time awareness and quick inspection of flood conditions. It is useful as a starting point for a larger disaster-response or environmental monitoring application.