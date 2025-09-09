import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TestHelpers {
  static Widget createTestableWidget(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: child,
      ),
    );
  }

  static Widget createTestableWidgetWithNavigator(Widget child) {
    return ProviderScope(
      child: MaterialApp(
        home: Scaffold(
          body: child,
        ),
      ),
    );
  }

  /// Helper to find text that might be in RichText widgets
  static Finder findTextAnywhere(String text) {
    return find.byWidgetPredicate((widget) {
      if (widget is Text) {
        return widget.data?.contains(text) == true;
      } else if (widget is RichText) {
        return widget.text.toPlainText().contains(text);
      }
      return false;
    });
  }

  /// Wait for all async operations and rebuilds
  static Future<void> pumpAndSettle(WidgetTester tester) async {
    await tester.pumpAndSettle();
  }

  /// Pump with custom duration
  static Future<void> pumpWithDuration(
    WidgetTester tester,
    Duration duration,
  ) async {
    await tester.pump(duration);
  }
}