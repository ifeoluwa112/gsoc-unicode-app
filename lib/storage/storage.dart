/// Central export file for all storage-related components in the Unicode
/// Flutter App.
///
/// This file serves as a central export point for all storage-related
/// functionality used throughout the application. It consolidates exports
/// from various storage directories, providing a clean and organized
/// way to import storage functionality.
///
/// Storage components handle all persistent data operations in the app,
/// including saving, retrieving, and managing user data, preferences,
/// and application state. The storage system uses Hive database for
/// efficient local data persistence.
///
/// Key Benefits:
/// - Centralized storage management
/// - Clean import statements
/// - Easy dependency tracking
/// - Consistent storage patterns
/// - Simplified refactoring
/// - Unified data persistence
///
/// Storage Features:
/// - Persistent character storage (favorites)
/// - Recently viewed character tracking
/// - User preference management
/// - Data serialization/deserialization
/// - Error handling and fallbacks
/// - Testing support
///
/// Architecture:
/// - Hive database for local storage
/// - JSON serialization for complex data
/// - Error handling with graceful fallbacks
/// - Testing support through dependency injection
/// - Consistent API across storage operations
///
/// Usage:
/// ```dart
/// import 'package:gsoc_unicode_app/storage/storage.dart';
///
/// // Access to all storage functionality
/// await AppStorage.saveCharacter(character);
/// final saved = AppStorage.getSavedCharacters();
/// ```
library;

/// Export for the main app storage class.
///
/// The AppStorage class provides a centralized interface for all
/// persistent storage operations in the app. It handles saving,
/// retrieving, and removing Unicode characters and recently viewed
/// characters using the Hive NoSQL database.
export 'app_storage.dart';

/// Export for storage keys and constants.
///
/// The StorageKeys file defines all the constants used for
/// identifying storage locations and keys in the Hive database.
/// These constants ensure consistency across the app and make
/// it easier to manage storage operations.
export 'storage_keys.dart';
