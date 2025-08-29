/// Defines storage keys and box names for Hive storage system.
///
/// This file contains all the constants used for identifying storage locations
/// and keys in the Hive NoSQL database. These constants ensure consistency
/// across the app and make it easier to manage storage operations.
///
/// The storage system uses a single Hive box to store all app data, with
/// different keys for different types of information. This approach provides
/// a clean separation of concerns while maintaining efficient storage access.
///
/// Storage Structure:
/// - Single Hive box: 'unicodeBox'
/// - Saved characters: 'saveUnicodeCharPropertiess'
/// - Recently viewed: 'recentlyViewedCharacter'
///
/// Usage:
/// ```dart
/// // Open the main storage box
/// final box = await Hive.openBox<String>(boxName);
///
/// // Store data using the defined keys
/// await box.put(savedCharactersKey, jsonData);
///
/// // Retrieve data using the same keys
/// final data = box.get(savedCharactersKey);
/// ```
library;

/// The name of the main Hive box for storing Unicode data.
///
/// This constant defines the name of the primary Hive box used by the app
/// for all persistent storage operations. The box stores all app data
/// as key-value pairs where both keys and values are strings.
///
/// The box name is used when initializing Hive and opening the storage
/// connection. It should remain consistent throughout the app's lifecycle
/// to ensure data persistence across app sessions.
///
/// Example:
/// ```dart
/// await Hive.initFlutter();
/// final box = await Hive.openBox<String>(boxName);
/// ```
const boxName = 'unicodeBox';

/// The key for saving the list of Unicode characters.
///
/// This constant defines the storage key used to save and retrieve the
/// user's list of saved/favorited Unicode characters. The data stored
/// under this key is a JSON-encoded string representing a list of
/// UnicodeCharProperties objects.
///
/// The key is used in conjunction with the main storage box to provide
/// persistent storage for user preferences and favorites. The data is
/// automatically serialized to JSON before storage and deserialized
/// when retrieved.
///
/// Example:
/// ```dart
/// // Save characters
/// await box.put(savedCharactersKey, jsonEncode(charactersList));
///
/// // Retrieve characters
/// final data = box.get(savedCharactersKey);
/// final characters = jsonDecode(data);
/// ```
const savedCharactersKey = 'saveUnicodeCharPropertiess';

/// The key for saving the list of recently viewed characters.
///
/// This constant defines the storage key used to save and retrieve the
/// user's browsing history of Unicode characters. The data stored under
/// this key is a JSON-encoded string representing a list of recently
/// viewed UnicodeCharProperties objects.
///
/// The key is used to track user browsing patterns and provide quick
/// access to recently viewed characters. The system automatically
/// manages this list to maintain a maximum of 5 entries and handles
/// deduplication to prevent duplicate entries.
///
/// Example:
/// ```dart
/// // Save recently viewed character
/// await box.put(recentCharacterKey, jsonEncode(recentCharactersList));
///
/// // Retrieve recently viewed characters
/// final data = box.get(recentCharacterKey);
/// final recentCharacters = jsonDecode(data);
/// ```
const recentCharacterKey = 'recentlyViewedCharacter';
