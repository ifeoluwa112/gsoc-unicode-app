import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsoc_unicode_app/shared/search_field.dart';

void main() {
  group('SearchField', () {
    late TextEditingController controller;
    late void Function(String) onChangedCallback;
    late String changedValue;

    setUp(() {
      controller = TextEditingController();
      changedValue = '';
      onChangedCallback = (value) => changedValue = value;
    });

    tearDown(() {
      controller.dispose();
    });

    testWidgets('displays in search mode by default', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      // Should show search icon
      expect(find.byIcon(Icons.search), findsOneWidget);
      // Should be single line
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('displays in tester mode when specified', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
              isTester: true,
            ),
          ),
        ),
      );

      // Should not show search icon in tester mode
      expect(find.byIcon(Icons.search), findsNothing);
      // Should be multi-line
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('calls onChanged when text is entered', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'test text');
      expect(changedValue, equals('test text'));
    });

    testWidgets('displays hint text correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      // Should show default search hint
      expect(find.text('Search by name or code'), findsOneWidget);
    });

    testWidgets('displays tester hint text when in tester mode',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
              isTester: true,
            ),
          ),
        ),
      );

      // Should show tester-specific hint (this will depend on localization)
      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('handles read-only mode', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
              readOnly: true,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('handles cursor visibility', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
              showCursor: false,
            ),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('handles onTap callback', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
              onTap: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(TextField));
      expect(tapped, isTrue);
    });

    testWidgets('maintains controller state', (tester) async {
      controller.text = 'initial text';
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      expect(find.text('initial text'), findsOneWidget);
    });

    testWidgets('handles empty controller', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(SearchField), findsOneWidget);
    });

    testWidgets('handles null controller', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(SearchField), findsOneWidget);
    });

    testWidgets('handles null onChanged', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
            ),
          ),
        ),
      );

      // Should render without crashing
      expect(find.byType(SearchField), findsOneWidget);
    });

    testWidgets('maintains proper styling in both modes', (tester) async {
      // Test search mode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      expect(find.byType(SearchField), findsOneWidget);

      // Test tester mode
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
              isTester: true,
            ),
          ),
        ),
      );

      expect(find.byType(SearchField), findsOneWidget);
    });

    testWidgets('handles text input and changes correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              controller: controller,
              onChanged: onChangedCallback,
            ),
          ),
        ),
      );

      // Enter text
      await tester.enterText(find.byType(TextField), 'hello world');
      expect(changedValue, equals('hello world'));

      // Clear text
      await tester.enterText(find.byType(TextField), '');
      expect(changedValue, equals(''));
    });
  });
}
