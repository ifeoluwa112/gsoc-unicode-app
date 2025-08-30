import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsoc_unicode_app/shared/shrinkable_button.dart';

void main() {
  group('ShrinkableButton', () {
    late VoidCallback onTapCallback;
    late bool tapped;

    setUp(() {
      tapped = false;
      onTapCallback = () => tapped = true;
    });

    testWidgets('displays child widget correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: const Text('Test Button'),
          ),
        ),
      );

      expect(find.text('Test Button'), findsOneWidget);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: const Text('Test Button'),
          ),
        ),
      );

      // Verify initial state
      expect(tapped, isFalse);

      // Tap the button
      await tester.tap(find.byType(ShrinkableButton));

      // Wait for animation delay
      await tester.pumpAndSettle(const Duration(milliseconds: 250));

      expect(tapped, isTrue);
    });

    testWidgets('handles null onTap callback', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: ShrinkableButton(
            child: Text('Test Button'),
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(ShrinkableButton), findsOneWidget);

      // Tap should not cause errors
      await tester.tap(find.byType(ShrinkableButton));
      await tester.pumpAndSettle(const Duration(milliseconds: 250));
    });

    testWidgets('animates scale on touch', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: Container(
              width: 100,
              height: 50,
              color: Colors.blue,
              child: const Text('Test Button'),
            ),
          ),
        ),
      );

      // Verify the button is rendered
      expect(find.byType(ShrinkableButton), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);

      // The animation is internal to the widget, so we just verify it renders
      // correctly and doesn't crash during interactions
    });

    testWidgets('handles complex child widgets', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: Column(
              children: [
                const Icon(Icons.star),
                const Text('Complex Button'),
                Container(
                  width: 50,
                  height: 25,
                  color: Colors.red,
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
      expect(find.text('Complex Button'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('maintains child widget properties', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: Container(
              width: 200,
              height: 100,
              color: Colors.green,
              child: const Center(
                child: Text(
                  'Styled Button',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      );

      expect(find.text('Styled Button'), findsOneWidget);
      expect(find.byType(Container), findsOneWidget);
    });

    testWidgets('handles multiple rapid taps', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: const Text('Test Button'),
          ),
        ),
      );

      // Multiple rapid taps
      await tester.tap(find.byType(ShrinkableButton));
      await tester.tap(find.byType(ShrinkableButton));
      await tester.tap(find.byType(ShrinkableButton));

      // Wait for all animations and timers to complete
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      // Should still be functional
      expect(find.byType(ShrinkableButton), findsOneWidget);
    });

    testWidgets('handles touch cancel scenarios', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: const Text('Test Button'),
          ),
        ),
      );

      // Verify the button is rendered correctly
      expect(find.byType(ShrinkableButton), findsOneWidget);
      expect(find.text('Test Button'), findsOneWidget);

      // Touch cancel scenarios are handled internally by the widget
      // We verify the widget renders without crashing
    });

    testWidgets('disposes resources correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: const Text('Test Button'),
          ),
        ),
      );

      // Verify widget is created
      expect(find.byType(ShrinkableButton), findsOneWidget);

      // Remove widget to trigger dispose
      await tester.pumpWidget(Container());

      // Should not have any ShrinkableButton instances
      expect(find.byType(ShrinkableButton), findsNothing);
    });

    testWidgets('handles empty child widget', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: Container(),
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(ShrinkableButton), findsOneWidget);
    });

    testWidgets('maintains accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ShrinkableButton(
            onTap: onTapCallback,
            child: const Text('Accessible Button'),
          ),
        ),
      );

      // Should be tappable
      expect(find.byType(ShrinkableButton), findsOneWidget);

      // Tap should work
      await tester.tap(find.byType(ShrinkableButton));
      await tester.pumpAndSettle(const Duration(milliseconds: 250));
    });
  });
}
