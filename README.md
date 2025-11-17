# Streaks

Minimal SwiftUI app for building healthy habits. Track progress, create new habits, and tweak reminders plus basic settings from a clean interface.

## Features

- Habit list with progress indicator and visual dot grid.
- Modal habit creation with custom color, icon, and reminder schedule.
- Settings screen with shortcuts to system settings, themes, archive, and Face ID & Passcode.

## Requirements

- macOS 15.0 (Sequoia) or newer.
- Xcode 16 / Swift 5.10.
- Target platform: iOS 17+.

## Quick Start

1. Open the project:
   ```bash
   open Streaks.xcodeproj
   ```
2. Select the `Streaks` scheme and a device (simulator or real).
3. Build and run (`⌘R`).

## Project Structure

```
Streaks/
├── Assets.xcassets/      # colors and app icons
├── ContentView.swift     # TabView with Habits and Settings tabs
├── Habit.swift           # Habit model + sample data
├── HabitRowView.swift    # habit card + HabitDotGrid
├── NewHabitView.swift    # habit creation form
├── FaceID.swift          # Face ID & Passcode screen
├── StreaksApp.swift      # app entry point
└── ...                   # Xcode support files
```

## Future Ideas

- Persist habits with CoreData/SwiftData.
- Add custom icon picker and notification handling.
- Replace placeholder settings actions with real flows.

## License

No license is included. Add one if you plan to distribute the project.

