/// Export file for the Unicode characters feature module.
///
/// This file provides centralized access to all components related to
/// Unicode character management in the app. It exports BLoCs, Cubits,
/// and other related functionality that enables the app to handle
/// Unicode character data, user interactions, and state management.
///
/// The Unicode characters feature is one of the core features of the
/// app, providing functionality for:
/// - Browsing and searching Unicode characters
/// - Managing saved/favorite characters
/// - Tracking recently viewed characters
/// - Character property information
/// - Font rendering and testing
///
/// Key Components:
/// - UnicodeCharPropertiesBloc: Main state management for character data
/// - SavedCharactersCubit: Manages user's saved/favorite characters
/// - RecentlyViewedCharacterCubit: Tracks browsing history
/// - RemoveSavedCharacterCubit: Handles character removal
/// - SaveCharacterCubit: Handles character saving
///
/// Architecture:
/// - BLoC pattern for complex state management
/// - Cubit pattern for simpler state operations
/// - Separation of concerns between different character operations
/// - Consistent state management patterns
///
/// Usage:
/// ```dart
/// import 'package:gsoc_unicode_app/features/unicode_characters/unicode_characters.dart';
///
/// // Access to all Unicode character functionality
/// final bloc = UnicodeCharPropertiesBloc();
/// final savedCubit = SavedCharactersCubit();
/// final recentCubit = RecentlyViewedCharacterCubit();
/// ```
library;

/// Export for the main Unicode characters BLoC.
///
/// This BLoC manages the state and operations related to Unicode
/// character data, including fetching, searching, and pagination.
/// It's the primary state management solution for character-related
/// operations in the app.
export 'blocs/unicode_characters_bloc.dart';

/// Export for managing all recently viewed characters.
///
/// This Cubit tracks and manages the user's browsing history of
/// Unicode characters, providing quick access to recently viewed
/// content. It maintains a list of the last few characters the
/// user has interacted with.
export 'cubits/all_recent_characters_cubit.dart';

/// Export for managing individual recently viewed characters.
///
/// This Cubit handles the addition and management of individual
/// recently viewed characters. It's used to update the browsing
/// history when users view character details.
export 'cubits/recently_viewed_character_cubit.dart';

/// Export for removing saved characters.
///
/// This Cubit provides functionality for removing characters from
/// the user's saved/favorites list. It handles the business logic
/// for character removal operations.
export 'cubits/remove_saved_character_cubit.dart';

/// Export for saving characters.
///
/// This Cubit manages the process of saving characters to the
/// user's favorites list. It handles the business logic for
/// character saving operations and updates the saved state.
export 'cubits/save_character_cubit.dart';

/// Export for managing saved characters.
///
/// This Cubit manages the user's saved/favorite characters list.
/// It provides functionality for retrieving, adding, and managing
/// the collection of characters that users have marked as favorites.
export 'cubits/saved_characters_cubit.dart';
