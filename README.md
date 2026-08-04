<div align="center">

# HabitsAndTasks

**A clean, bilingual to-do list app built with Flutter**

[![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=flat&logo=Flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-%230175C2.svg?style=flat&logo=dart&logoColor=white)](https://dart.dev)
[![Platform](https://img.shields.io/badge/platform-Android%20%7C%20iOS-informational)](#)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](#-contributing)

</div>

## Overview

**HabitsAndTasks** is a lightweight, well-structured to-do list app built with Flutter. It covers the full loop of a task manager — add, complete, revert, delete — wrapped in a polished Material UI with complete English/Arabic localization and a confirmation dialog in front of every meaningful action. It was built as a hands-on exercise in state management, internationalization, and clean widget architecture.

## 📸 Screenshots

Screenshots aren't included yet. Once added to `assets/screenshots/`, the Home, Add Task, and Completed Tasks screens will be showcased here.

## ✨ Features

**Task management**
- Add a task with a title, description, and a specific due date & time via native date and time pickers
- Mark a task complete — it moves automatically from the active list into a dedicated Completed Tasks screen
- Revert a completed task back to active, with a confirmation prompt
- Delete individual tasks — active or completed — with a confirmation dialog
- Clear every active task in one action, with a confirmation dialog
- Live task counters in the app bar for both active and completed tasks
- Friendly empty-state messaging when a list has nothing to show

**Localization & UX**
- Full English / Arabic localization via `easy_localization`, including translated month names and AM/PM labels
- Instant in-app language switching from the navigation drawer — no restart required
- Automatic right-to-left layout when Arabic is active, built on Flutter's native RTL support
- A confirmation dialog (via `awesome_dialog`) in front of every destructive or state-changing action, so nothing happens by accident

**Design**
- Custom Material theme built from a deep-purple color seed, with a coral (`#F08080`) accent across app bars and primary actions
- Card-based list layout with clear visual separation between active and completed tasks

## 🛠️ Tech Stack

| Category | Package | Version |
|---|---|---|
| Framework | Flutter / Dart | Dart SDK `>=3.9.1 <4.0.0` |
| State management | [`provider`](https://pub.dev/packages/provider) | `^6.1.5+1` |
| Localization | [`easy_localization`](https://pub.dev/packages/easy_localization) | `^3.0.8` |
| Dialogs & alerts | [`awesome_dialog`](https://pub.dev/packages/awesome_dialog) | `^3.3.0` |
| Icons | `cupertino_icons` | `^1.0.8` |
| Linting | `flutter_lints` | `^6.0.0` |
| Platforms | Android, iOS | — |

## 📂 Project Structure

```
HabitsAndTasks/
├── lib/
│   ├── main.dart                 # App entry point — EasyLocalization & Provider setup
│   ├── Home.dart                 # Home screen: active task list, app bar actions
│   ├── add_task.dart             # Floating action button + "Add Task" dialog & date/time pickers
│   ├── drawer.dart                # Navigation drawer (language switcher)
│   ├── complete_age/
│   │   └── complete.dart          # Completed tasks screen
│   └── logic/
│       ├── data.dart               # ToDoList model
│       ├── To do list.dart         # LogicToDoList — app state & business logic (ChangeNotifier)
│       └── change-language.dart    # Locale toggle helper
├── assets/
│   ├── icons/                     # UI icon assets
│   └── translations/
│       ├── en-US.json
│       └── ar-EG.json
├── test/
│   └── widget_test.dart
└── pubspec.yaml
```

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) installed and on your `PATH`
- Android Studio / Xcode for platform builds, or any editor with the Flutter/Dart extensions
- A connected device, emulator, or simulator

### Installation

```bash
# Clone the repository
git clone https://github.com/Amr4924/HabitsAndTasks.git
cd HabitsAndTasks

# Install dependencies
flutter pub get

# Run the app
flutter run
```

## 🌍 Localization

<img src="assets/icons/lang-support.svg" alt="English / Arabic language support" width="120" />

The app ships with complete English and Arabic translations:

```
assets/translations/
├── en-US.json
└── ar-EG.json
```

Switch languages at runtime from **Drawer → Options → Change Language** — it takes effect immediately, no restart required. Arabic automatically renders right-to-left, since Flutter derives text direction from the active locale.

To add another language:
1. Add the new locale to `supportedLocales` in `lib/main.dart`
2. Create a matching JSON file in `assets/translations/` (e.g. `fr-FR.json`) using the same keys as `en-US.json`

## 🗺️ Roadmap

The app currently keeps all data in memory for the running session only. Natural next steps:

- [ ] **Persistent storage** — tasks reset on app restart today; add local persistence (e.g. `shared_preferences` or `Hive`)
- [ ] **Reminders** — each task already captures a due date & time; wire it up to `flutter_local_notifications` to put it to use
- [ ] **Automated tests** — `test/widget_test.dart` is still the default Flutter counter test; replace it with real widget/unit tests
- [ ] **Custom app icon & splash screen** — currently using the default Flutter launcher icon
- [ ] **Recurring / habit-style tasks** — repeat schedules and streaks, to grow the app into its name

## 🤝 Contributing

Contributions, issues, and suggestions are welcome:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/your-feature`
3. Commit your changes with clear, focused messages
4. Run `flutter analyze` and `flutter test` before opening a PR
5. Open a pull request describing the change

## 📄 License

No license file is included yet. If this project is meant to be reused or distributed, consider adding one — [MIT](https://choosealicense.com/licenses/mit/) is a common, permissive choice for portfolio projects.

## 👤 Author

Built by [**Amr**](https://github.com/Amr4924), as part of an ongoing, hands-on journey into Flutter development.

---

<div align="center">
<sub>Built with Flutter</sub>
</div>
