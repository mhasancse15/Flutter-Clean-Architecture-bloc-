# Flutter Clean Architecture Demo

A minimal example of **Clean Architecture** applied to a Flutter application. The project showcases how to:

- Organise code into layers (presentation, domain, data, and core) while keeping dependencies pointing **inward**.
- Use **dependency injection** with the `initializePostDependencies` helper to register feature‑specific providers.
- Manage state with **flutter_bloc** and provide repositories, data sources, and use‑cases via `RepositoryProvider`.

---

## Project Structure

```
lib/
├─ core/                 # Core utilities shared across the app
│   ├─ app/               # App‑level observers, routes, etc.
│   └─ networking/        # API client abstraction
├─ features/               # Feature‑by‑feature modules
│   └─ post/               # Example "Post" feature
│       ├─ di.dart          # Feature DI – `initializePostDependencies`
│       ├─ blocs/          # Bloc classes handling UI events
│       └─ ...
├─ main.dart               # App entry point – sets up global and feature DI
└─ ...
```

---

## Dependency Injection – `initializePostDependencies`

The function defined in `lib/features/post/di.dart` builds a **list of `RepositoryProvider` objects** for the Post feature:

```dart
List initializePostDependencies() {
  return [
    // Data source
    RepositoryProvider(
      create: (context) => PostRemoteDataSourceImpl(context.read<ApiClient>()),
    ),
    // Repository implementation
    RepositoryProvider(
      create: (context) => PostRepositoryImpl(context.read<PostRemoteDataSourceImpl>()),
    ),
    // Use‑cases
    RepositoryProvider(
      create: (context) => GetPostUseCase(context.read<PostRepositoryImpl>()),
    ),
    RepositoryProvider(
      create: (context) => CreatePostUseCase(context.read<PostRepositoryImpl>()),
    ),
  ];
}
```

In `main.dart` the **spread operator** (`...`) inserts each provider into the top‑level `MultiRepositoryProvider` list:

```dart
runApp(
  MultiRepositoryProvider(
    providers: [
      RepositoryProvider(create: (_) => ApiClient()),
      ...initializePostDependencies(), // <-- spreads the list
    ],
    child: MultiBlocProvider(
      providers: [
        ...initializePostBlocs(),
      ],
      child: const MyApp(),
    ),
  ),
);
```

This keeps the `main.dart` file clean and makes the Post feature **plug‑and‑play** – you can add or remove it by editing only the `di.dart` file.

---

## Getting Started

1. **Install Flutter** (stable channel) – see https://flutter.dev.
2. Clone the repository:
   ```bash
   git clone <repo‑url>
   cd flutter-clean-architecture-master
   ```
3. Fetch dependencies:
   ```bash
   flutter pub get
   ```
4. Run the app on an emulator or device:
   ```bash
   flutter run
   ```

---

## Running Tests

The project includes unit tests for the domain layer and widget tests for the UI. Run them with:

```bash
flutter test
```

---

## Contributing

Feel free to open issues or PRs. When adding new features, follow the same pattern:
- Create a feature folder under `lib/features/<name>/`.
- Add a `di.dart` that returns a list of providers for that feature.
- Spread the list in `main.dart` with `...initialize<Feature>Dependencies()`.

---

## License

MIT License – see `LICENSE` file.
