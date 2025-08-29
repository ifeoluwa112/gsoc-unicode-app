/// Central export file for all shared components in the Unicode Flutter App.
///
/// This file serves as a central export point for all shared/reusable
/// components that are used across multiple screens and features in
/// the application. It consolidates exports from various shared
/// directories, providing a clean and organized way to import
/// common functionality.
///
/// Shared components are designed to be reusable and consistent
/// across the app, providing a unified user experience and
/// reducing code duplication. They include UI widgets, utilities,
/// and other components that serve multiple purposes.
///
/// Key Benefits:
/// - Centralized shared component management
/// - Clean import statements
/// - Easy dependency tracking
/// - Consistent component organization
/// - Simplified refactoring
/// - Reusable component library
///
/// Component Categories:
/// - UI Widgets: Reusable interface components
/// - Utilities: Helper functions and classes
/// - Extensions: Dart language extensions
/// - Constants: App-wide constants and values
///
/// Usage:
/// ```dart
/// import 'package:gsoc_unicode_app/shared/shared.dart';
///
/// // Access to all shared components
/// CustomAppBar(title: 'Screen Title')
/// SearchField(onChanged: (value) => {})
/// CharacterTile(character: 'A', onTap: () => {})
/// ```
library;

/// Export for the character tile widget.
///
/// A reusable widget that displays Unicode character information
/// in a consistent format. Used throughout the app for displaying
/// character lists, search results, and character details.
export 'character_tile.dart';

/// Export for the custom app bar widget.
///
/// A customizable app bar component that provides consistent
/// navigation and styling across all screens in the app.
/// Supports various configurations for different screen requirements.
export 'custom_app_bar.dart';

/// Export for the search field widget.
///
/// A versatile text input component that supports both search
/// and tester modes. Automatically adapts its appearance and
/// behavior based on the selected mode.
export 'search_field.dart';

/// Export for the shrinkable button widget.
///
/// A button component that provides tactile feedback through
/// scale animation. Used for interactive elements that benefit
/// from visual feedback during user interactions.
export 'shrinkable_button.dart';

/// Export for the unfocus utility widget.
///
/// A utility widget that automatically unfocuses input fields
/// when tapping outside. Implements the common UX pattern of
/// dismissing keyboards and input focus.
export 'unfocus.dart';
