/// Export file for the home screen feature module.
///
/// This file provides centralized access to all components related to
/// the home screen functionality in the app. It exports the main home
/// screen and supporting widgets that serve as the primary entry point
/// for users to access different Unicode tools and features.
///
/// The home screen is the main landing page after the splash screen,
/// providing users with a clean interface to choose between the
/// two main tools available in the app:
/// - Unicode Character Visualizer
/// - Multilingual Tester
///
/// Key Components:
/// - HomeScreen: Main tool selection interface
/// - ToolBox: Individual tool selection widget
/// - Supporting utilities and helpers
///
/// Architecture:
/// - Screen-based organization
/// - Widget composition for reusability
/// - Responsive design support
/// - Consistent styling with app theme
/// - Clean navigation patterns
///
/// User Experience:
/// - Intuitive tool selection interface
/// - Clear descriptions of each tool's purpose
/// - Visual icons for easy recognition
/// - Responsive layout for different screen sizes
/// - Smooth navigation to selected tools
///
/// Usage:
/// ```dart
/// import 'package:gsoc_unicode_app/ui/home/home.dart';
///
/// // Access to home screen components
/// HomeScreen()
/// ToolBox(tool: 'Tool Name', onTap: () {}, icon: Icons.tool)
/// ```
library;

/// Export for the main home screen.
///
/// The primary interface where users can choose between different
/// Unicode tools available in the app. This screen provides a
/// welcoming interface with clear descriptions and easy access
/// to the app's main functionality.
export 'views/home_screen.dart';

/// Export for the tool box selection widget.
///
/// A reusable widget for displaying individual tool options
/// on the home screen. Each tool box includes a title, description,
/// icon, and touch interaction for navigation to the selected tool.
export 'widgets/tool_box.dart';
