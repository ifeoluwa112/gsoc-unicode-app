import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gsoc_unicode_app/features/unicode_characters/cubits/saved_characters_cubit.dart';
import 'package:gsoc_unicode_app/shared/character_tile.dart';
import 'package:gsoc_unicode_app/ui/visualizer/views/saved_screen.dart';
import '../../helpers/test_helpers.dart';

class FakeSavedCharactersCubit extends SavedCharactersCubit {
  FakeSavedCharactersCubit(this._state) : super();
  final SavedCharactersState _state;
  @override
  SavedCharactersState get state => _state;
}

void main() {
  group('SavedScreen', () {
    testWidgets('shows empty state when no characters', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.loaded(characters: []),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );
      expect(
        find.textContaining(
          'No saved characters',
          findRichText: true,
          skipOffstage: false,
        ),
        findsOneWidget,
      );
    });

    testWidgets('SavedScreen shows CharacterTile when characters are present', (
      tester,
    ) async {
      final character = createTestCharacter();
      final fakeCubit = FakeSavedCharactersCubit(
        SavedCharactersState.loaded(characters: [character]),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      // Wait for the widget to build
      await tester.pumpAndSettle();

      expect(find.byType(CharacterTile), findsOneWidget);
      expect(find.text('U+0041'), findsOneWidget);
      // Check for the character display (the large "A")
      expect(
          find.text('A'), findsOneWidget); // Character appears once in the tile
    });

    testWidgets('shows multiple characters correctly', (tester) async {
      final character1 = createTestCharacter();
      final character2 = createTestCharacter(character: 'B');
      final character3 = createTestCharacter(character: 'C');

      final fakeCubit = FakeSavedCharactersCubit(
        SavedCharactersState.loaded(
            characters: [character1, character2, character3]),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CharacterTile), findsNWidgets(3));
      expect(find.text('A'), findsOneWidget);
      expect(find.text('B'), findsOneWidget);
      expect(find.text('C'), findsOneWidget);
    });

    testWidgets('shows loading state correctly', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.loading(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      // Loading state shows empty list, so should show "no saved characters"
      // message
      expect(find.textContaining('No saved characters'), findsOneWidget);
    });

    testWidgets('shows error state correctly', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.error(error: 'Test error'),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      // Error state shows empty list, so should show "no saved characters"
      // message
      expect(find.textContaining('No saved characters'), findsOneWidget);
    });

    testWidgets('shows initial state correctly', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.initial(),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      expect(find.byType(SavedScreen), findsOneWidget);
    });

    testWidgets('displays app bar correctly', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.loaded(characters: []),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('handles emoji characters correctly', (tester) async {
      final emojiCharacter = createTestEmoji();
      final fakeCubit = FakeSavedCharactersCubit(
        SavedCharactersState.loaded(characters: [emojiCharacter]),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.byType(CharacterTile), findsOneWidget);
      expect(find.text('😀'), findsOneWidget);
      expect(find.text('U+1F600'), findsOneWidget);
    });

    testWidgets('maintains proper layout structure', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.loaded(characters: []),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      expect(find.byType(Scaffold), findsOneWidget);
      expect(find.byType(AppBar), findsOneWidget);
    });

    testWidgets('handles different screen sizes', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.loaded(characters: []),
      );

      // Test with different screen sizes
      await tester.binding.setSurfaceSize(const Size(400, 800));
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      expect(find.byType(SavedScreen), findsOneWidget);

      // Reset surface size
      await tester.binding.setSurfaceSize(null);
    });

    testWidgets('displays character information correctly', (tester) async {
      final character = createTestCharacter(
        character: 'Z',
        name: 'LATIN CAPITAL LETTER Z',
        unicodeValue: 'U+005A',
      );

      final fakeCubit = FakeSavedCharactersCubit(
        SavedCharactersState.loaded(characters: [character]),
      );
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      await tester.pumpAndSettle();

      expect(find.text('Z'), findsOneWidget);
      expect(find.text('LATIN CAPITAL LETTER Z'), findsOneWidget);
      expect(find.text('U+005A'), findsOneWidget);
    });

    testWidgets('handles theme changes', (tester) async {
      final fakeCubit = FakeSavedCharactersCubit(
        const SavedCharactersState.loaded(characters: []),
      );

      // Test with light theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.light(),
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      expect(find.byType(SavedScreen), findsOneWidget);

      // Test with dark theme
      await tester.pumpWidget(
        MaterialApp(
          theme: ThemeData.dark(),
          home: BlocProvider<SavedCharactersCubit>.value(
            value: fakeCubit,
            child: const SavedScreen(),
          ),
        ),
      );

      expect(find.byType(SavedScreen), findsOneWidget);
    });
  });
}
