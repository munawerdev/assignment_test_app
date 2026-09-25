# GYB Commerce Movie App

A Flutter movie discovery app built for the GYB Commerce assignment. It loads upcoming movies from TMDB, supports movie search and detail pages, plays available YouTube trailers, and includes a UI-only seat selector.

## Requirements

- Flutter stable 3.47.0 (Dart 3.13.0)
- Android SDK / Xcode for the target platform

## Run

```sh
flutter pub get
flutter run
```

The app currently uses the TMDB API key in `lib/core/constants/global.dart`.

## Features

- Upcoming movie list with pull to refresh
- Search with popular movie suggestions and debounced results
- Movie detail, genres, overview, and available trailer playback
- Responsive portrait and landscape layouts
- UI-only seat selection from **Get Tickets** (no booking service is connected)

## Structure

- `lib/features/`: feature-first UI and Cubit state management
- `lib/data/models/`: TMDB response models
- `lib/data/repositories/network/`: Dio network implementation and error handling
- `lib/domain/`: network service interface and failure types
- `lib/config/`: navigation, API response states, and theme

Key packages: `flutter_bloc` for state management, `get_it` for dependency injection, `dio` for HTTP, `cached_network_image` for TMDB artwork, `flutter_screenutil` for responsive sizing, and `youtube_player_flutter` for trailer playback.

## Build

```sh
flutter analyze
flutter build apk --release
```
