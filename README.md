# Accommodation App

A Flutter accommodation booking application supporting two tenant configurations: Alpine and Riviera.

## Requirements

- Flutter 3.47.7
- Dart 3.13.5
- A running instance of the provided mock API

## Running the App

Run commands from the repository root.

### Alpine

```bash
flutter run \
  -t apps/accommodation_app/lib/main.dart \
  --dart-define=TENANT_SLUG=alpine \
  --dart-define=API_BASE_URL=http://localhost:8080
```

### Riviera

```bash
flutter run \
  -t apps/accommodation_app/lib/main.dart \
  --dart-define=TENANT_SLUG=riviera \
  --dart-define=API_BASE_URL=http://localhost:8080
```

### API Configuration

The application expects the mock API to be available on port `8080`.

| Target           | Base URL                                             |
| ---------------- | ---------------------------------------------------- |
| iOS simulator    | `http://localhost:8080`                              |
| Android emulator | `http://10.0.2.2:8080`                               |
| Physical device  | `http://<your-machine-ip>:8080` (same Wi-Fi network) |

Replace `API_BASE_URL` with the appropriate address for your target device.

## Code Generation

Run from the package containing the generated files:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Localization

Translations are maintained in ARB files. After updating them, run from `packages/accommodation_ui`:

```bash
flutter gen-l10n
```

## Tests

Run all tests from the repository root:

```bash
melos run test
```
