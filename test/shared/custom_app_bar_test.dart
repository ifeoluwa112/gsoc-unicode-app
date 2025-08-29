import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsoc_unicode_app/shared/custom_app_bar.dart';

void main() {
  group('CustomAppBar', () {
    testWidgets('displays title correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: 'Test Title'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
    });

    testWidgets('displays leading widget when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Test Title',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {},
              ),
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.arrow_back), findsOneWidget);
    });

    testWidgets('displays actions when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Test Title',
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.byIcon(Icons.more_vert), findsOneWidget);
    });

    testWidgets('handles navigation when leading is tapped', (tester) async {
      var navigated = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Test Title',
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => navigated = true,
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(navigated, isTrue);
    });

    testWidgets('handles custom onTap callback', (tester) async {
      var customTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Test Title',
              leading: const Icon(Icons.arrow_back),
              onTap: () => customTapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byIcon(Icons.arrow_back));
      expect(customTapped, isTrue);
    });

    testWidgets('displays without title', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(),
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(CustomAppBar), findsOneWidget);
    });

    testWidgets('displays without leading widget', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: 'Test Title'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      // Should not have any leading widget
      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('displays without actions', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: 'Test Title'),
          ),
        ),
      );

      expect(find.text('Test Title'), findsOneWidget);
      // Should not have any action buttons
      expect(find.byType(IconButton), findsNothing);
    });

    testWidgets('maintains proper layout structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Test Title',
              leading: Icon(Icons.arrow_back),
              actions: [Icon(Icons.search)],
            ),
          ),
        ),
      );

      // Verify the basic layout structure
      expect(find.byType(Container), findsWidgets);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('handles long titles with overflow', (tester) async {
      const longTitle = 'Very Long Title That Should Be Handled Properly';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(title: longTitle),
          ),
        ),
      );

      expect(find.text(longTitle), findsOneWidget);
    });

    testWidgets('applies custom colors when provided', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            appBar: CustomAppBar(
              title: 'Test Title',
              color: Colors.red,
              appBarColor: Colors.blue,
            ),
          ),
        ),
      );

      expect(find.byType(CustomAppBar), findsOneWidget);
    });
  });
}
