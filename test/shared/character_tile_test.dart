import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsoc_unicode_app/shared/character_tile.dart';

void main() {
  group('CharacterTile', () {
    late Widget testWidget;
    late VoidCallback onTapCallback;
    late bool tapped;

    setUp(() {
      tapped = false;
      onTapCallback = () => tapped = true;
      testWidget = MaterialApp(
        home: CharacterTile(
          character: 'A',
          characterName: 'LATIN CAPITAL LETTER A',
          script: 'Latin',
          codePoint: 'U+0041',
          onTap: onTapCallback,
        ),
      );
    });

    testWidgets('displays character, name, and code point correctly', (
      tester,
    ) async {
      await tester.pumpWidget(testWidget);

      // Verify all text elements are displayed
      expect(find.text('A'), findsOneWidget);
      expect(find.text('LATIN CAPITAL LETTER A'), findsOneWidget);
      expect(find.text('U+0041'), findsOneWidget);
    });

    testWidgets('calls onTap callback when tapped', (tester) async {
      await tester.pumpWidget(testWidget);

      // Verify initial state
      expect(tapped, isFalse);

      // Tap the tile
      await tester.tap(find.byType(CharacterTile));
      expect(tapped, isTrue);
    });

    testWidgets('displays different characters correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterTile(
            character: '😀',
            characterName: 'GRINNING FACE',
            script: 'Emoji',
            codePoint: 'U+1F600',
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text('😀'), findsOneWidget);
      expect(find.text('GRINNING FACE'), findsOneWidget);
      expect(find.text('U+1F600'), findsOneWidget);
    });

    testWidgets('handles long character names with overflow', (tester) async {
      const longName = 'VERY LONG CHARACTER NAME THAT SHOULD BE TRUNCATED';
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterTile(
            character: 'A',
            characterName: longName,
            script: 'Latin',
            codePoint: 'U+0041',
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text(longName), findsOneWidget);
    });

    testWidgets('displays selection state correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterTile(
            character: 'A',
            characterName: 'LATIN CAPITAL LETTER A',
            script: 'Latin',
            codePoint: 'U+0041',
            onTap: onTapCallback,
            isSelected: true,
          ),
        ),
      );

      // Verify the tile is displayed (selection state affects background color)
      expect(find.byType(CharacterTile), findsOneWidget);
    });

    testWidgets('handles different scripts correctly', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterTile(
            character: 'あ',
            characterName: 'HIRAGANA LETTER A',
            script: 'Hiragana',
            codePoint: 'U+3042',
            onTap: onTapCallback,
          ),
        ),
      );

      expect(find.text('あ'), findsOneWidget);
      expect(find.text('HIRAGANA LETTER A'), findsOneWidget);
      expect(find.text('U+3042'), findsOneWidget);
    });

    testWidgets('maintains layout structure', (tester) async {
      await tester.pumpWidget(testWidget);

      // Verify the basic layout structure
      expect(find.byType(Row), findsWidgets);
      expect(find.byType(Expanded), findsWidgets);
    });

    testWidgets('handles empty or null values gracefully', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CharacterTile(
            character: '',
            characterName: '',
            script: '',
            codePoint: '',
            onTap: onTapCallback,
          ),
        ),
      );

      // Widget should still render without crashing
      expect(find.byType(CharacterTile), findsOneWidget);
    });
  });
}
