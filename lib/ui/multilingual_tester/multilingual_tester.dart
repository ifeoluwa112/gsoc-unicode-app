/// Export file for the multilingual tester feature module.
///
/// This file provides centralized access to all components related to
/// the multilingual tester functionality in the app. It exports the
/// main screen and supporting widgets that enable users to test and
/// compare text rendering across different font families and scripts.
///
/// The multilingual tester is a key feature that allows users to:
/// - Input multilingual text for testing
/// - Automatically detect Unicode scripts
/// - Select appropriate fonts for detected scripts
/// - Preview text rendering in different fonts
/// - Compare font rendering quality
/// - Test multilingual content display
///
/// Key Components:
/// - MultilingualTesterScreen: Main testing interface
/// - FontBox: Font selection widget
/// - Supporting utilities and helpers
///
/// Architecture:
/// - Screen-based organization
/// - Widget composition for reusability
/// - State management with Flutter Hooks
/// - Responsive design support
/// - Consistent styling with app theme
///
/// Usage:
/// ```dart
/// import 'package:gsoc_unicode_app/ui/multilingual_tester/multilingual_tester.dart';
///
/// // Access to multilingual tester components
/// MultilingualTesterScreen()
/// FontBox(fontName: 'Arial', onTap: () {}, isSelected: false)
/// ```
library;

/// Export for the main multilingual tester screen.
///
/// The primary interface for testing multilingual text rendering.
/// This screen provides a comprehensive testing environment where
/// users can input text, select fonts, and preview rendering
/// across different font families and Unicode scripts.
export 'views/multilingual_tester_screen.dart';

/// Export for the font box selection widget.
///
/// A reusable widget for selecting font families in the
/// multilingual tester. Provides visual feedback for selection
/// states and supports touch interactions for font selection.
export 'widgets/font_box.dart';
