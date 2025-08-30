/// Extensions on [BuildContext] for convenient access to theme and padding
/// values.
///
/// This file provides convenient extension methods on BuildContext that
/// simplify access to commonly used theme and padding values throughout
/// the app. These extensions reduce boilerplate code and provide a
/// more readable API for accessing context-dependent values.
///
/// The extensions are designed to be safe and provide sensible defaults
/// when values are not available. They encapsulate common patterns for
/// accessing theme data and safe area information.
///
/// Key Features:
/// - Easy access to text theme from context
/// - Safe area padding calculations with defaults
/// - Consistent API across the app
/// - Reduced boilerplate code
/// - Type-safe access to theme properties
///
/// Usage:
/// ```dart
/// // Access text theme
/// final textStyle = context.textTheme.displayLarge;
///
/// // Get top padding with safe area
/// final topPadding = context.topPadding;
///
/// // Get bottom padding with safe area
/// final bottomPadding = context.btmPadding;
/// ```
library;

import 'package:flutter/material.dart';

/// Extension for accessing theme and padding values from [BuildContext].
///
/// This extension provides convenient methods for accessing commonly
/// used values from the BuildContext, including theme data and safe
/// area padding calculations. It simplifies the common pattern of
/// accessing these values throughout the app.
///
/// The extension methods are designed to be safe and provide sensible
/// defaults when values are not available. They encapsulate the logic
/// for accessing theme data and calculating safe area padding.
extension ThemeContextExtension on BuildContext {
  /// Returns the current [TextTheme] from the context.
  ///
  /// This getter provides easy access to the text theme from the current
  /// context. It's equivalent to `Theme.of(this).textTheme` but more
  /// concise and readable.
  ///
  /// The text theme contains all the predefined text styles used
  /// throughout the app, including display styles, body styles, and
  /// label styles. This ensures consistent typography across the UI.
  ///
  /// Returns:
  /// - The current TextTheme from the context
  ///
  /// Example:
  /// ```dart
  /// Text(
  ///   'Hello World',
  ///   style: context.textTheme.displayLarge,
  /// )
  /// ```
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Returns the top safe area padding plus 5 pixels.
  ///
  /// This getter calculates the top safe area padding and adds 5 pixels
  /// for additional spacing. It's useful for positioning elements below
  /// the status bar or notch area while maintaining consistent spacing.
  ///
  /// The 5-pixel addition provides a small buffer zone that improves
  /// visual balance and prevents elements from being too close to the
  /// safe area boundary.
  ///
  /// Returns:
  /// - Top safe area padding plus 5 pixels
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   margin: EdgeInsets.only(top: context.topPadding),
  ///   child: Text('Content below status bar'),
  /// )
  /// ```
  double get topPadding => MediaQuery.of(this).viewPadding.top + 5;

  /// Returns the bottom safe area padding plus 5 pixels.
  ///
  /// This getter calculates the bottom safe area padding and adds 5 pixels
  /// for additional spacing. It's useful for positioning elements above
  /// the home indicator or navigation bar while maintaining consistent spacing.
  ///
  /// The 5-pixel addition provides a small buffer zone that improves
  /// visual balance and prevents elements from being too close to the
  /// safe area boundary.
  ///
  /// Returns:
  /// - Bottom safe area padding plus 5 pixels
  ///
  /// Example:
  /// ```dart
  /// Container(
  ///   margin: EdgeInsets.only(bottom: context.btmPadding),
  ///   child: Text('Content above home indicator'),
  /// )
  /// ```
  double get btmPadding => MediaQuery.of(this).viewPadding.bottom + 5;
}
