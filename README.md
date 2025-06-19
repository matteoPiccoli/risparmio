# risparmio

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


```
lib/
├── main.dart                   # Entry point
├── app/                        # App-wide config (themes, routes, etc.)
│   ├── app.dart                # MaterialApp, routing
│   └── themes/                 # ThemeData for light/dark modes
├── core/                       # Global utilities and shared resources
│   ├── db/                     # Database
│   ├── constants/              # App-wide constants, enums, colors
│   ├── utils/                  # Formatters, extensions, helpers
│   └── widgets/                # Reusable UI components (buttons, cards)
├── features/                   # Modular feature-based structure
│   ├── transaction/
│   │   ├── data/               # DB layer (sqflite or drift), Pure business logic (no imports from Flutter)
│   │   │   ├── models/         # TransactionModel (for serialization), Core models: Transaction
│   │   │   ├── datasources/    # SQLite service, local data provider
│   │   │   └── repositories/   # Concrete repo implementing domain interface, Abstract interfaces (e.g., TransactionRepository)
│   │   └── presentation/       # UI + state management
│   │       ├── view/           # Screens (TransactionListScreen, AddTransactionScreen)
│   │       ├── view_model/     # State management (e.g., Riverpod, Provider)
│   │       └── widgets/        # Feature-specific widgets
│   ├── reports/
│   │   ├── domain/
│   │   ├── data/
│   │   └── presentation/
│   └── settings/
│       └── presentation/       # Usually just UI, like theme toggle
├── l10n/                       # Localization (optional)


test/
├── features/
│   ├── transaction/
│   │   ├── view_model/
│   │   ├── widgets/
│   │   └── integration/
├── core/
├── data/
└── utils/
```


## Current app structure

UI Layer (widgets, screens)
     ↓
State Management Layer (e.g., Riverpod providers)
     ↓
Repository Layer (TransactionRepository)
     ↓
Data Access Layer (TransactionDao)
     ↓
Local DB (SQLite via sqflite)

## How to go "inside" the database of my app
 1. Run the app from the emulator
 2. Open the terminal and type the following:

``` 
adb shell
run-as com.example.risparmio --> app name can be found in android/app/build.gradle.kts
cd databases
ls
```

# Copy to your local machine the database
```
adb exec-out run-as com.example.risparmio cat databases/finance_tracker.db > ~/Downloads/finance_tracker.db
```



// TODO:
- Try to summarize in one place the categories and transactions fields. And re-use them. This allows ease reuse for the database.
- Try to understand notifier, provider and state
- Understand the futures and async programming with dart.