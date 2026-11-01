# Bantay Baha

A Real-Time Flood Monitoring System

## Credits

A Huge Thanks and Credits to [haliknihudas666](https://github.com/haliknihudas666) and his project [bahaba](https://github.com/haliknihudas666/bahaba) for the api in this app.

## Architecture and Project Structure

This Project uses MVVM architecture 

### State management
| Ephemeral State | App State | App Wide Services |
|-----------------|-----------|-------------------|
|setState | ChangeNotifier | Locator/Service Locator|

### Project Structure

| Folder/file |	Responsibility |
|-------------|----------------|
|app/ |	App configuration, navigation, dependency registration|
|models/ | Data structures such as FloodReading|
|services/ |	API requests, database access, authentication|
|ui/views/ |	Screens and their ViewModels|
|ui/views/home/widgets/ |	Components used specifically by the Home screen|
|ui/widgets/common/	| Reusable UI components|
|test/ |	Unit tests for ViewModels and services|
|main.dart |	Application entry point|


## RoadMap
- [x] Display leaflets from the api
  - [x] Parsing
- [x] Auto Reaload on interval
- [ ] Refactor codebase to stack architecture
- [ ] Telemetry Dashboard
- [ ] Geocoding for searching places

## Getting Started

- Grab deps
```bash
flutter pub get
```

- Running
```bash
flutter run
```

A few resources to get you started if this is your first Flutter project:

- [Learn Flutter](https://docs.flutter.dev/get-started/learn-flutter)
- [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Flutter learning resources](https://docs.flutter.dev/reference/learning-resources)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

