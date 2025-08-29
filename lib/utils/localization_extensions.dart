/// Extensions on [BuildContext] for safe localization access.
///
/// This file provides a safe way to access localization data from the
/// BuildContext throughout the app. It ensures that localization is
/// always available, even if not properly provided by the widget tree,
/// by providing fallback localization when needed.
///
/// The extension implements a defensive programming approach to prevent
/// localization-related crashes and ensure the app remains functional
/// even in edge cases where localization might not be available.
///
/// Key Features:
/// - Safe access to AppLocalizations from any BuildContext
/// - Automatic fallback to English localization if primary fails
/// - Prevents localization-related crashes
/// - Consistent API across the app
/// - Type-safe access to localized strings
///
/// Usage:
/// ```dart
/// // Safe access to localized strings
/// final title = context.appLocalizations.appTitle;
/// final message = context.appLocalizations.welcomeMessage;
///
/// // Always returns a valid localization instance
/// final locale = context.appLocalizations;
/// ```
library;

import 'package:flutter/material.dart';
import 'package:gsoc_unicode_app/i10n/app_localizations.dart';
import 'package:gsoc_unicode_app/i10n/app_localizations_en.dart';

/// Extension for safely accessing [AppLocalizations] from [BuildContext].
///
/// This extension provides a safe method to access localization data
/// from any BuildContext in the app. It implements a fallback mechanism
/// that ensures localization is always available, even in edge cases
/// where the primary localization might not be properly provided.
///
/// The extension uses the null-aware operator to check if localization
/// is available, and if not, falls back to the English localization
/// as a default. This prevents crashes and ensures the app remains
/// functional in all scenarios.
///
/// Safety Features:
/// - Null-safe access to AppLocalizations
/// - Automatic fallback to English localization
/// - Prevents localization-related crashes
/// - Maintains app functionality in edge cases
///
/// Fallback Behavior:
/// - Primary: AppLocalizations.of(this) if available
/// - Fallback: AppLocalizationsEn() if primary is null
/// - Result: Always returns a valid localization instance
extension SafeLocalizations on BuildContext {
  /// Returns the current [AppLocalizations] or a fallback if unavailable.
  ///
  /// This getter provides safe access to localization data from the
  /// current BuildContext. It first attempts to retrieve the primary
  /// localization, and if that fails, falls back to English localization
  /// to ensure the app remains functional.
  ///
  /// The method is designed to be robust and handle edge cases gracefully:
  /// - Widget tree not properly configured with localization
  /// - Localization not yet initialized
  /// - Missing localization files or resources
  /// - Testing scenarios without full localization setup
  ///
  /// Returns:
  /// - The current AppLocalizations if available
  /// - AppLocalizationsEn() as a fallback if primary is null
  ///
  /// Example:
  /// ```dart
  /// // Safe access to any localized string
  /// final title = context.appLocalizations.appTitle;
  /// final message = context.appLocalizations.welcomeMessage;
  ///
  /// // Use in widgets
  /// Text(context.appLocalizations.chooseTool)
  /// ```
  AppLocalizations get appLocalizations =>
      AppLocalizations.of(this) ?? AppLocalizationsEn();
}
