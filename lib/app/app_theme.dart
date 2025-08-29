/// Defines the application's theme and styling constants.
///
/// The AppTheme class provides a centralized location for all theme-related
/// values used throughout the Unicode Flutter App. This includes colors,
/// text styles, and other visual properties that ensure consistency
/// across the entire application.
///
/// By centralizing theme definitions, the app maintains a cohesive visual
/// identity and makes it easier to implement design changes or create
/// alternative themes in the future.
///
/// Key Features:
/// - Centralized color definitions for consistent branding
/// - Predefined text styles for typography consistency
/// - Easy-to-modify theme values for app-wide changes
/// - Support for both light and dark theme variants (future expansion)
/// - Semantic color naming for better code readability
///
/// Usage:
/// ```dart
/// Container(
///   color: AppTheme.searchColor,
///   child: Text('Search', style: AppTheme.lightTextTheme.displayLarge),
/// )
/// ```
library;

import 'package:flutter/material.dart';

/// A class that defines the app's theme and styles.
///
/// This class contains all the visual styling constants used throughout
/// the application, including colors, text themes, and other styling
/// properties. It is used throughout the app to maintain a consistent
/// look and feel.
///
/// The theme values are designed to work well together and provide
/// a professional, accessible appearance. Colors are chosen for good
/// contrast and readability, while text styles ensure consistent
/// typography across all screens.
class AppTheme {
  /// The background color for search fields and input areas.
  ///
  /// This light gray color provides subtle visual separation for
  /// interactive elements while maintaining good contrast with text.
  /// It's used consistently across search fields, input boxes, and
  /// other form elements.
  static const searchColor = Color(0xFFF8F8F8);

  /// A light blue accent shade with custom alpha transparency.
  ///
  /// This color is used for interactive elements like buttons, links,
  /// and selection highlights. The custom alpha value (0.2) creates
  /// a subtle, non-intrusive accent that enhances the user interface
  /// without overwhelming the content.
  static final Color blueShade = Colors.lightBlueAccent.shade100.withValues(
    alpha: 0.2,
  );

  /// A white shade used for borders and subtle separators.
  ///
  /// This light gray color provides gentle visual boundaries between
  /// UI elements. It's used for borders, dividers, and other
  /// separation elements to create visual hierarchy without being
  /// too prominent.
  static const whiteShade = Color(0xFFD9D9D9);

  /// The main screen background shade for the entire application.
  ///
  /// This very light blue-gray color serves as the primary background
  /// for all screens. It provides a clean, professional appearance
  /// while offering subtle visual interest compared to pure white.
  /// The color is light enough to ensure good contrast with dark text.
  static const screenShade = Color(0XFFF8FAFC);

  /// Light text theme for consistent typography throughout the app.
  ///
  /// This text theme defines the default typography styles used
  /// across the application. It ensures consistent font sizes, weights,
  /// and colors for different text elements like headings, body text,
  /// and labels.
  ///
  /// The theme is designed for light backgrounds and provides good
  /// readability and visual hierarchy. Future versions may include
  /// additional text styles for different content types.
  static const lightTextTheme = TextTheme(
    displayLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  );
}
