/// Utility class for managing persistent storage using Hive database.
///
/// The AppStorage class provides a centralized interface for all persistent
/// storage operations in the Unicode Flutter App. It handles saving,
/// retrieving, and removing Unicode characters and recently viewed characters
/// using the Hive NoSQL database for efficient local storage.
///
/// This class implements a simple key-value storage system where Unicode
/// character data is serialized to JSON format before storage and deserialized
/// when retrieved. It provides methods for managing both saved characters
/// (user favorites) and recently viewed characters (browsing history).
///
/// Key Features:
/// - Persistent storage of Unicode character data
/// - Automatic JSON serialization/deserialization
/// - Management of saved characters (favorites)
/// - Tracking of recently viewed characters (history)
/// - Error handling with graceful fallbacks
/// - Testing support through test box injection
///
/// Storage Structure:
/// - Saved characters: List of user-favorited Unicode characters
/// - Recently viewed: List of last 5 viewed characters (with deduplication)
///
/// Usage:
/// ```dart
/// // Initialize storage
/// await AppStorage.init();
///
/// // Save a character
/// await AppStorage.saveCharacter(character);
///
/// // Retrieve saved characters
/// final saved = AppStorage.getSavedCharacters();
/// ```
library;

import 'dart:convert';

import 'package:dart_icu4x/dart_icu4x.dart';
import 'package:flutter/foundation.dart';
import 'package:gsoc_unicode_app/storage/storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

/// Provides static methods for interacting with app storage.
///
/// This class manages all persistent storage operations using Hive database.
/// It provides methods for saving, retrieving, and removing Unicode character
/// data, as well as managing recently viewed character history.
///
/// The class uses a single Hive box for all storage operations and provides
/// JSON serialization for complex data structures. All methods include
/// error handling to ensure the app continues to function even if storage
/// operations fail.
///
/// Note: This class is designed to be used statically and should not be
/// instantiated. All methods are static and operate on the same storage
/// instance.
class AppStorage {
  /// The main Hive box instance for storing all app data.
  ///
  /// This box stores all persistent data as key-value pairs where keys
  /// are strings and values are JSON-encoded strings. The box is opened
  /// during initialization and remains open for the app's lifetime.
  static Box<String>? _box;

  /// Initializes Hive and opens the main storage box if not already open.
  ///
  /// This method must be called before any other storage operations.
  /// It initializes the Hive Flutter plugin and opens the main storage
  /// box. If the box is already open, no action is taken.
  ///
  /// This method is typically called in the app's main() function or
  /// during app initialization to ensure storage is ready for use.
  static Future<void> init() async {
    await Hive.initFlutter();
    if (!boxInitialized()) {
      _box = await Hive.openBox<String>(boxName);
    }
  }

  /// Checks if the main storage box is initialized and open.
  ///
  /// Returns true if the storage box is available and ready for use,
  /// false otherwise. This method is useful for checking storage
  /// status before attempting operations.
  ///
  /// Returns:
  /// - true if the box is open and ready
  /// - false if the box is not initialized or closed
  static bool boxInitialized() {
    return _box?.isOpen ?? false;
  }

  /// Opens a Hive box with the given [boxName].
  ///
  /// This method allows opening additional storage boxes if needed.
  /// It's primarily used for testing or when multiple storage
  /// locations are required.
  ///
  /// Parameters:
  /// - [boxName]: The name of the box to open
  static Future<void> open(String boxName) async {
    _box = await Hive.openBox(boxName);
  }

  /// Closes the currently open Hive box and releases resources.
  ///
  /// This method should be called when the app is shutting down or
  /// when storage is no longer needed. It ensures proper cleanup
  /// of database connections and file handles.
  static Future<void> close() async {
    await Hive.close();
  }

  /// Clears all data from the currently open Hive box.
  ///
  /// This method removes all stored data, effectively resetting the
  /// app's persistent storage. Use with caution as this operation
  /// cannot be undone.
  ///
  /// This method is useful for:
  /// - App reset functionality
  /// - Clearing user data on logout
  /// - Testing and development purposes
  static Future<void> clear() async {
    await _box?.clear();
  }

  /// Saves a [UnicodeCharProperties] to the saved characters list in storage.
  ///
  /// This method adds a character to the user's saved/favorites list.
  /// The character is inserted at the beginning of the list, making it
  /// the most recently saved item. If the character already exists in
  /// the list, it's moved to the top.
  ///
  /// The method handles JSON serialization of the character data and
  /// includes error handling to prevent app crashes if storage fails.
  ///
  /// Parameters:
  /// - [character]: The UnicodeCharProperties object to save
  ///
  /// Example:
  /// ```dart
  /// await AppStorage.saveCharacter(myUnicodeCharacter);
  /// ```
  static Future<void> saveCharacter(UnicodeCharProperties character) async {
    try {
      // Get existing saved characters and add new one at the beginning
      final characterList = [...getSavedCharacters()]..insert(0, character);

      // Serialize the list to JSON and store it
      final encoded = jsonEncode(characterList.map((c) => c.toJson()).toList());
      await _box?.put(savedCharactersKey, encoded);
    } on Exception catch (e) {
      // Log error but don't crash the app
      debugPrint(e.toString());
    }
  }

  /// Retrieves the list of saved Unicode characters from storage.
  ///
  /// This method returns all characters that the user has saved as
  /// favorites. The list is maintained in order of most recently
  /// saved first. If no characters are saved or an error occurs,
  /// an empty list is returned.
  ///
  /// The method handles JSON deserialization and includes error
  /// handling to ensure the app continues to function even if
  /// storage data is corrupted.
  ///
  /// Returns:
  /// - List of saved UnicodeCharProperties objects
  /// - Empty list if none found or on error
  ///
  /// Example:
  /// ```dart
  /// final savedCharacters = AppStorage.getSavedCharacters();
  /// for (final character in savedCharacters) {
  ///   print('Saved: ${character.character}');
  /// }
  /// ```
  static List<UnicodeCharProperties> getSavedCharacters() {
    try {
      // Retrieve the JSON string from storage
      final savedCharacters = _box?.get(savedCharactersKey);
      var characterList = <UnicodeCharProperties>[];

      if (savedCharacters != null) {
        // Deserialize the JSON string back to character objects
        final decoded = jsonDecode(savedCharacters) as List<dynamic>;
        characterList = decoded
            .map((e) =>
                (e as Map<String, dynamic>).fromUnicodeCharPropertiesJson())
            .toList();
      }
      return characterList;
    } on Exception catch (e) {
      // Log error and return empty list to prevent app crashes
      debugPrint(e.toString());
      return [];
    }
  }

  /// Saves a [UnicodeCharProperties] as recently viewed.
  ///
  /// This method tracks the user's browsing history by saving characters
  /// they have viewed. The character is added to the beginning of the
  /// recently viewed list, and if it already exists, it's moved to the
  /// top. Only the last 5 viewed characters are kept to limit storage usage.
  ///
  /// The method automatically handles deduplication and list size management.
  /// It's useful for providing users with quick access to recently
  /// viewed characters.
  ///
  /// Parameters:
  /// - [character]: The UnicodeCharProperties object to mark as recently viewed
  ///
  /// Example:
  /// ```dart
  /// await AppStorage.saveRecentlyViewedCharacter(viewedCharacter);
  /// ```
  static Future<void> saveRecentlyViewedCharacter(
    UnicodeCharProperties character,
  ) async {
    try {
      // Get existing recently viewed characters
      final characterList = [...getRecentlyViewedCharacters()]
        // Remove any existing instance of this character
        ..removeWhere((c) => c.character == character.character)
        // Add the new character at the beginning
        ..insert(0, character);

      // Serialize and store the updated list
      final encoded = jsonEncode(characterList.map((c) => c.toJson()).toList());
      await _box?.put(recentCharacterKey, encoded);
    } on Exception catch (e) {
      // Log error but don't crash the app
      debugPrint(e.toString());
    }
  }

  /// Retrieves the list of recently viewed Unicode characters from storage.
  ///
  /// This method returns the user's browsing history of Unicode characters.
  /// The list is limited to the last 5 viewed characters to prevent
  /// excessive storage usage. Characters are ordered by most recently
  /// viewed first.
  ///
  /// The method includes error handling and will return an empty list
  /// if no history exists or if an error occurs during retrieval.
  ///
  /// Returns:
  /// - List of recently viewed UnicodeCharProperties objects (max 5)
  /// - Empty list if none found or on error
  ///
  /// Example:
  /// ```dart
  /// final recentCharacters = AppStorage.getRecentlyViewedCharacters();
  /// for (final character in recentCharacters) {
  ///   print('Recently viewed: ${character.character}');
  /// }
  /// ```
  static List<UnicodeCharProperties> getRecentlyViewedCharacters() {
    try {
      // Retrieve the JSON string from storage
      final encoded = _box?.get(recentCharacterKey);
      if (encoded == null) return [];

      // Deserialize the JSON string back to character objects
      final decoded = jsonDecode(encoded) as List;
      final characters = decoded
          .map((item) =>
              (item as Map<String, dynamic>).fromUnicodeCharPropertiesJson())
          .toList();

      // Limit to last 5 characters to prevent excessive storage usage
      return characters.take(5).toList();
    } on Exception catch (e) {
      // Log error and return empty list to prevent app crashes
      debugPrint(e.toString());
      return [];
    }
  }

  /// Removes a [UnicodeCharProperties] from the saved characters list in
  /// storage.
  ///
  /// This method removes a character from the user's saved/favorites list.
  /// The character is identified by its character value, and all instances
  /// are removed from the list. The updated list is then saved back to storage.
  ///
  /// This method is useful for implementing "remove from favorites"
  /// functionality
  /// or cleaning up saved characters that are no longer needed.
  ///
  /// Parameters:
  /// - [character]: The UnicodeCharProperties object to remove
  ///
  /// Example:
  /// ```dart
  /// await AppStorage.removeCharacter(unwantedCharacter);
  /// ```
  static Future<void> removeCharacter(UnicodeCharProperties character) async {
    try {
      // Get existing saved characters and remove the specified one
      final characterList = [...getSavedCharacters()]
        ..removeWhere((c) => c.character == character.character);

      // Serialize and store the updated list
      final encoded = jsonEncode(characterList.map((c) => c.toJson()).toList());
      await _box?.put(savedCharactersKey, encoded);
    } on Exception catch (e) {
      // Log error but don't crash the app
      debugPrint(e.toString());
    }
  }

  /// Sets the box for testing purposes only.
  ///
  /// This method allows injection of a test Hive box for unit testing.
  /// It's marked with @visibleForTesting to indicate it should only
  /// be used in test code, not in production.
  ///
  /// Parameters:
  /// - [box]: The Hive box to use for testing
  @visibleForTesting
  static set testBox(Box<String>? box) {
    _box = box;
  }

  /// Gets the box for testing purposes only.
  ///
  /// This method provides access to the current storage box for testing
  /// purposes. It's marked with @visibleForTesting to indicate it should
  /// only be used in test code, not in production.
  ///
  /// Returns:
  /// - The current Hive box instance or null if not initialized
  @visibleForTesting
  static Box<String>? get testBox => _box;
}
