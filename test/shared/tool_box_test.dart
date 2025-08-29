import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsoc_unicode_app/ui/home/widgets/tool_box.dart';

void main() {
  group('ToolBox', () {
    late VoidCallback onTapCallback;
    late bool tapped;

    setUp(() {
      tapped = false;
      onTapCallback = () => tapped = true;
    });

    testWidgets('displays tool name correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text('Test Tool'), findsOneWidget);
    });

    testWidgets('displays description correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text('Test Description'), findsOneWidget);
    });

    testWidgets('displays icon correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      // Verify initial state
      expect(tapped, isFalse);

      // Tap the tool box
      await tester.tap(find.byType(ToolBox));

      // Wait for the ShrinkableButton animation delay
      await tester.pumpAndSettle(const Duration(milliseconds: 250));

      expect(tapped, isTrue);
    });

    testWidgets('handles long tool names', (tester) async {
      const longToolName =
          'This is a very long tool name that might overflow the container';

      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: longToolName,
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text(longToolName), findsOneWidget);
      expect(find.byType(ToolBox), findsOneWidget);
    });

    testWidgets('handles long descriptions', (tester) async {
      const longDescription =
          '''This is a very long description that describes the tool in great detail and might also overflow the container''';

      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: longDescription,
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text(longDescription), findsOneWidget);
      expect(find.byType(ToolBox), findsOneWidget);
    });

    testWidgets('handles different icon types', (tester) async {
      final testIcons = [
        Icons.search,
        Icons.home,
        Icons.settings,
        Icons.info,
        Icons.help,
      ];

      for (final icon in testIcons) {
        await tester.pumpWidget(
          MaterialApp(
            home: ToolBox(
              tool: 'Test Tool',
              description: 'Test Description',
              icon: icon,
              onTap: onTapCallback,
            ),
          ),
        );

        expect(find.byIcon(icon), findsOneWidget);
      }
    });

    testWidgets('maintains layout structure', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      // Should contain all required elements
      expect(find.byType(ToolBox), findsOneWidget);
      expect(
          find.byType(Icon), findsNWidgets(2)); // tool icon + navigation arrow
      expect(find.byType(Text), findsNWidgets(2)); // tool name and description
    });

    testWidgets('handles empty strings gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: '',
            description: '',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(ToolBox), findsOneWidget);
      expect(find.byIcon(Icons.star), findsOneWidget);
    });

    testWidgets('handles special characters in text', (tester) async {
      const specialText =
          r'Tool with special chars: !@#$%^&*()_+-=[]{}|;:,.<>?';

      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: specialText,
            description: 'Description with émojis 🚀 and unicode 🌟',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text(specialText), findsOneWidget);
      expect(find.text('Description with émojis 🚀 and unicode 🌟'),
          findsOneWidget);
    });

    testWidgets('handles onTap callback execution', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(ToolBox), findsOneWidget);

      // Tap should execute callback
      await tester.tap(find.byType(ToolBox));
      await tester.pumpAndSettle(const Duration(milliseconds: 250));
      expect(tapped, isTrue);
    });

    testWidgets('maintains accessibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Accessible Tool',
            description: 'Accessible Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      // Should be tappable
      expect(find.byType(ToolBox), findsOneWidget);

      // Tap should work
      await tester.tap(find.byType(ToolBox));
      await tester.pumpAndSettle(const Duration(milliseconds: 250));
      expect(tapped, isTrue);
    });

    testWidgets('handles multiple tool boxes', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Column(
            children: [
              ToolBox(
                tool: 'Tool 1',
                description: 'Description 1',
                icon: Icons.star,
                onTap: () {},
              ),
              ToolBox(
                tool: 'Tool 2',
                description: 'Description 2',
                icon: Icons.home,
                onTap: () {},
              ),
              ToolBox(
                tool: 'Tool 3',
                description: 'Description 3',
                icon: Icons.settings,
                onTap: () {},
              ),
            ],
          ),
        ),
      );

      expect(find.byType(ToolBox), findsNWidgets(3));
      expect(find.text('Tool 1'), findsOneWidget);
      expect(find.text('Tool 2'), findsOneWidget);
      expect(find.text('Tool 3'), findsOneWidget);
    });

    testWidgets('handles rapid taps', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: ToolBox(
            tool: 'Test Tool',
            description: 'Test Description',
            icon: Icons.star,
            onTap: onTapCallback,
          ),
        ),
      );

      // Multiple rapid taps
      await tester.tap(find.byType(ToolBox));
      await tester.tap(find.byType(ToolBox));
      await tester.tap(find.byType(ToolBox));

      // Wait for all timers to complete
      await tester.pumpAndSettle(const Duration(milliseconds: 300));

      // Should still be functional
      expect(find.byType(ToolBox), findsOneWidget);
    });
  });
}
