<!--
	Professional README for the ToDo app.
	Replace the screenshot and demo links with actual assets in /assets/screenshots/
-->

# ToDoLocalizer (To Do List)

[![Flutter](https://img.shields.io/badge/Framework-Flutter-blue)](https://flutter.dev)
[![Language-Dart](https://img.shields.io/badge/Language-Dart-0175C2)](https://dart.dev)
[![License-MIT](https://img.shields.io/badge/License-MIT-lightgrey)](LICENSE)

<img src="assets/icons/lang-support.svg" alt="Language Support" width="140" />

Beautiful, localized To‑Do list app built with Flutter — lightweight, animated, and ready for customization.

---

## Demo

- Animated splash, smooth list transitions, and Lottie/Rive dialogs (suggested).

![screenshot-1](assets/screenshots/screenshot-1.png "App Home")

GIF demo (replace with actual GIF in `assets/screenshots/demo.gif`):

![demo](assets/screenshots/demo.gif)

---

## Key Features

- Add / delete tasks with animated dialogs
- Mark tasks complete and view completed tasks
- Localization (English / Arabic) via `easy_localization`
- Provider for state management
- Animated UI hooks ready for `rive` or `lottie`

---

## Design & Animation Notes

- Use a Rive or Lottie animated splash (add .riv / .json to `assets/animations`).
- Use `ImplicitlyAnimatedList` or `AnimatedList` for insert/delete animations.
- Replace `AwesomeDialog` content with a Lottie animation for success/warning screens.

Recommended libraries

- `rive` (for interactive vector animations)
- `lottie` / `lottie_flutter`
- `flutter_launcher_icons` (for app icons)
- `flutter_animate` or `animations`

---

## Quick Start

1. Install dependencies

```bash
flutter pub get
```

2. Generate launcher icons (optional)

```bash
flutter pub run flutter_launcher_icons:main
```

3. Run the app

```bash
flutter run
```

---

## Project Structure (high level)

- `lib/` — app source
  - `main.dart` — app entry and localization setup
  - `Home.dart` — main UI
  - `add_task.dart`, `dialog.dart`, `complete/` — features
- `assets/translations/` — JSON translation files
- `assets/animations/` — Rive / Lottie files (add your own)

---

## Screenshots / Assets

Add the following files to `assets/screenshots/` and commit:

- `screenshot-1.png` — home screen
- `demo.gif` — short demo GIF (250–600px width recommended)

For animations put `.riv` or `.json` into `assets/animations/` and list them in `pubspec.yaml`.

---

## Contributing

- Fork → branch → PR. Add small, focused commits.
- Run `flutter analyze` and `flutter test` before PR.

---

If you want, I can:

- generate a polished `assets/screenshots/demo.gif` placeholder (using repo screenshots), or
- add a Rive splash and wire it into `main.dart` now. Which do you prefer?
