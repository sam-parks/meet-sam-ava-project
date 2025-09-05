import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meet_sam_ava/app_router.dart';
import 'package:meet_sam_ava/core/theme/providers/theme_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeNotifierProvider);
    final lightTheme = ref.watch(lightThemeProvider);
    final darkTheme = ref.watch(darkThemeProvider);
    final router = AppRouter();

    return MaterialApp.router(
      title: 'MVVM + Riverpod 3 + AutoRoute + Formz',
      routerConfig: router.config(
        navigatorObservers: () => [AutoRouteObserver()],
      ),
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: themeMode == ThemeMode.system
          ? ThemeMode.system
          : themeMode == ThemeMode.dark
              ? ThemeMode.dark
              : ThemeMode.light,
    );
  }
}
