# Flutter MVVM + Riverpod 3 + AutoRoute + Formz

A minimal, production-friendly starter with:

- **Riverpod 3 (dev)** using the `@riverpod` generator style
- **AutoRoute v9** with `routerConfig`
- **Formz** for form inputs + validation
- **custom_lint** + **riverpod_lint** enabled via `analysis_options.yaml`

## Getting started

> Requires Flutter 3.24+ and Dart 3.6+

```bash
flutter pub get
dart run build_runner build -d
flutter run -d chrome # or your preferred device
```

## Project structure

```bash
lib/
  main.dart
  app_router.dart
  features/auth/
    model/login_inputs.dart
    vm/login_view_model.dart
    view/login_page.dart
  features/home/view/home_page.dart
```

## Linting

- `custom_lint` runs automatically in your IDE.
- To run manually:

```bash
dart run custom_lint
```

## Notes

- Riverpod 3 is on the dev channel; APIs are close to stable but may change slightly.
- Generated files (`*.g.dart`) are excluded from analysis and version control by default.
