/// A utility widget that automatically unfocuses input fields when tapping
/// outside.
///
/// The Unfocus widget implements a common UX pattern where tapping in empty
/// space automatically removes focus from any active input fields.
/// This provides
/// a more intuitive user experience by allowing users to dismiss keyboards
/// and input focus without having to manually tap outside the input area.
///
/// This widget is typically used as a wrapper around the entire app content
/// to ensure consistent unfocus behavior throughout the application. It's
/// particularly useful in mobile apps where keyboard management is important
/// for user experience.
///
/// Key Features:
/// - Automatically unfocuses all input fields when tapping outside
/// - Works with any type of input field (TextField, TextFormField, etc.)
/// - Transparent to user interactions - doesn't interfere with normal app
/// behavior
/// - Lightweight implementation with minimal performance impact
/// - Consistent behavior across the entire application
///
/// Usage:
/// ```dart
/// MaterialApp(
///   builder: (context, child) {
///     return Unfocus(child: child!);
///   },
///   // ... rest of app configuration
/// )
/// ```
library;

import 'package:flutter/material.dart';

/// {@template unfocus}
/// A widget that automatically unfocuses all input fields when tapped.
///
/// This widget implements the common UX pattern of "unfocus when tapping
/// in empty space" for the entire application. It wraps the app content
/// and provides transparent unfocus functionality without interfering with
/// normal user interactions.
///
/// The widget uses a GestureDetector with HitTestBehavior.opaque to ensure
/// that taps are properly detected and handled. When a tap occurs, it
/// automatically unfocuses the currently focused input field, which typically
/// dismisses the keyboard on mobile devices.
/// {@endtemplate}
class Unfocus extends StatelessWidget {
  /// {@macro unfocus}
  ///
  /// Creates an Unfocus widget that wraps the specified child.
  ///
  /// The [child] parameter is required and represents the content that
  /// should have unfocus behavior applied to it. This is typically the
  /// entire app content or a specific screen's content.
  const Unfocus({required this.child, super.key});

  /// The child widget that should have unfocus behavior applied.
  ///
  /// This can be any Flutter widget, but it's typically used to wrap
  /// the entire app content or specific screens where unfocus behavior
  /// is desired.
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Ensure that taps are detected even in transparent areas
      behavior: HitTestBehavior.opaque,

      // Unfocus the currently focused input field when tapped
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),

      // Pass through the child widget without modification
      child: child,
    );
  }
}
