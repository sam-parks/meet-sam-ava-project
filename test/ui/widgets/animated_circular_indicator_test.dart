import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:meet_sam_ava/shared/widgets/animated_circular_indicator.dart';
import '../../helpers/test_helpers.dart';

void main() {
  setUpAll(() {
    // Disable visibility detector for tests to prevent timer issues
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
  });

  group('AnimatedCircularIndicator Widget Tests', () {
    testWidgets('should display progress indicator with main text', (WidgetTester tester) async {
      // Arrange
      const testValue = 0.75;
      const testText = '750';
      
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: testValue,
            maxValue: 1.0,
            displayText: testText,
            size: 100,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.byType(AnimatedCircularIndicator), findsOneWidget);
    });

    testWidgets('should display progress indicator with main text and subtext', (WidgetTester tester) async {
      // Arrange
      const testValue = 0.5;
      const testText = '500';
      const testSubText = 'Score';
      
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: testValue,
            maxValue: 1.0,
            displayText: testText,
            subText: testSubText,
            size: 100,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text(testText), findsOneWidget);
      expect(find.text(testSubText), findsOneWidget);
      expect(find.byType(AnimatedCircularIndicator), findsOneWidget);
    });

    testWidgets('should handle different sizes correctly', (WidgetTester tester) async {
      // Test small size
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.8,
            maxValue: 1.0,
            displayText: '800',
            size: 60,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Find the SizedBox that contains our size constraint
      final sizedBox = find.byType(SizedBox);
      expect(sizedBox, findsWidgets);
      
      // Test large size
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.9,
            maxValue: 1.0,
            displayText: '900',
            size: 120,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('900'), findsOneWidget);
    });

    testWidgets('should handle zero and full progress values', (WidgetTester tester) async {
      // Test zero progress
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.0,
            maxValue: 1.0,
            displayText: '0',
            size: 100,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('0'), findsOneWidget);

      // Test full progress
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 1.0,
            maxValue: 1.0,
            displayText: '100',
            size: 100,
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('100'), findsOneWidget);
    });

    testWidgets('should handle custom colors', (WidgetTester tester) async {
      // Arrange
      const customBackgroundColor = Colors.blue;
      const customProgressColor = Colors.green;
      
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.6,
            maxValue: 1.0,
            displayText: '600',
            size: 100,
            backgroundColor: customBackgroundColor,
            progressColor: customProgressColor,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - widget should render without errors
      expect(find.text('600'), findsOneWidget);
      expect(find.byType(AnimatedCircularIndicator), findsOneWidget);
    });

    testWidgets('should handle very long text gracefully', (WidgetTester tester) async {
      // Test with very long text to ensure it doesn't cause overflow
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.5,
            maxValue: 1.0,
            displayText: 'Very Long Text That Might Overflow',
            subText: 'Also a very long subtitle that might cause issues',
            size: 80,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Should render without throwing layout overflow errors
      expect(tester.takeException(), isNull);
    });

    testWidgets('should animate progress changes', (WidgetTester tester) async {
      // Start with initial value
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.3,
            maxValue: 1.0,
            displayText: '300',
            size: 100,
          ),
        ),
      );
      
      // Let initial animation complete
      await tester.pumpAndSettle();
      
      // Change the value to trigger animation
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.8,
            maxValue: 1.0,
            displayText: '800',
            size: 100,
          ),
        ),
      );
      
      // Pump a few frames to see animation in progress
      await tester.pump(const Duration(milliseconds: 100));
      await tester.pump(const Duration(milliseconds: 200));
      
      // Let animation complete
      await tester.pumpAndSettle();
      
      expect(find.text('800'), findsOneWidget);
    });

    testWidgets('should respect custom text styles', (WidgetTester tester) async {
      // Arrange
      const customTextStyle = TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.red,
      );
      const customSubTextStyle = TextStyle(
        fontSize: 12,
        color: Colors.blue,
      );
      
      // Act
      await tester.pumpWidget(
        TestHelpers.createTestableWidget(
          const AnimatedCircularIndicator(
            value: 0.7,
            maxValue: 1.0,
            displayText: '700',
            subText: 'Custom',
            size: 100,
            textStyle: customTextStyle,
            subTextStyle: customSubTextStyle,
          ),
        ),
      );
      await tester.pumpAndSettle();

      // Assert - widget should render without errors
      expect(find.text('700'), findsOneWidget);
      expect(find.text('Custom'), findsOneWidget);
    });
  });
}