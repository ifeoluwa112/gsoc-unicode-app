/// Central export file for all UI components in the Unicode Flutter App.
///
/// This file serves as a central export point for all UI-related
/// components used throughout the application. It consolidates exports
/// from various UI directories, providing a clean and organized
/// way to import UI functionality.
///
/// UI components represent the user interface layer of the application,
/// including screens, widgets, and other visual elements. These
/// components are organized by feature and provide the complete
/// user experience for the app.
///
/// Key Benefits:
/// - Centralized UI management
/// - Clean import statements
/// - Easy dependency tracking
/// - Consistent UI organization
/// - Simplified refactoring
/// - Organized feature-based structure
///
/// UI Structure:
/// - Home: Main tool selection interface
/// - Layout: App-wide layout components
/// - Multilingual Tester: Font testing interface
/// - Settings: App configuration interface
/// - Visualizer: Unicode character exploration interface
///
/// Architecture:
/// - Feature-based organization
/// - Consistent navigation patterns
/// - Reusable UI components
/// - Responsive design support
/// - Accessibility considerations
///
/// Usage:
/// ```dart
/// import 'package:gsoc_unicode_app/ui/ui.dart';
///
/// // Access to all UI components
/// HomeScreen()
/// MultilingualTesterScreen()
/// SettingsScreen()
/// ```
library;

/// Export for home screen components.
///
/// Provides access to the main home screen and related components
/// where users can choose between different Unicode tools and
/// features available in the app.
export 'home/home.dart';

/// Export for layout components.
///
/// Provides access to app-wide layout components including
/// the base screen with bottom navigation and other layout
/// utilities used across multiple screens.
export 'layout/layout.dart';

/// Export for multilingual tester components.
///
/// Provides access to the multilingual tester interface where
/// users can test text rendering in different fonts and
/// compare multilingual text display.
export 'multilingual_tester/multilingual_tester.dart';

/// Export for visualizer components.
///
/// Provides access to the Unicode character visualizer interface
/// where users can browse, search, and explore Unicode characters
/// with detailed information and font rendering examples.
export 'visualizer/visualizer.dart';
