import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_sam_ava/app_router.dart';
import 'package:meet_sam_ava/core/theme/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  final AppRouter router = AppRouter();

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(appThemeProvider);

    return MaterialApp.router(
      title: 'MVVM + Riverpod 3 + AutoRoute + Formz',
      routerConfig: router.config(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      theme: theme,
      themeMode: ThemeMode.light,
    );
  }
}
