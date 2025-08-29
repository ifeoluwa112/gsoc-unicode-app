/// A customizable search text field widget with multi-mode support.
///
/// The SearchField widget is a versatile text input component that can be
/// configured for different use cases throughout the app. It supports both
/// single-line search mode and multi-line tester mode, with appropriate
/// styling and behavior for each context.
///
/// The widget automatically adapts its appearance and functionality based
/// on the isTester parameter, providing an optimal user experience for
/// both search operations and text input scenarios. It includes built-in
/// styling that matches the app's design system and supports various
/// customization options.
///
/// Key Features:
/// - Dual-mode operation (search vs. tester)
/// - Automatic styling based on mode
/// - Configurable cursor and read-only states
/// - Touch interaction support
/// - Consistent design with app theme
/// - Multi-line support for tester mode
/// - Customizable hint text and icons
/// - Responsive layout and styling
///
/// Usage:
/// ```dart
/// // Search mode
/// SearchField(
///   onChanged: (value) => performSearch(value),
///   controller: searchController,
/// )
///
/// // Tester mode
/// SearchField(
///   isTester: true,
///   onChanged: (value) => handleTextInput(value),
///   controller: textController,
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsoc_unicode_app/app/app_theme.dart';
import 'package:gsoc_unicode_app/utils/utils.dart';

/// A search field with optional multi-line and tester mode support.
///
/// This widget provides a flexible text input solution that can be
/// configured for different use cases. In search mode, it behaves like
/// a traditional search field with a search icon and single-line input.
/// In tester mode, it becomes a multi-line text area suitable for
/// entering and testing multilingual content.
///
/// The widget automatically adjusts its appearance, behavior, and
/// styling based on the selected mode, ensuring optimal user experience
/// for each context. It maintains consistent design language with the
/// rest of the app while providing the flexibility needed for different
/// input scenarios.
///
/// Mode Differences:
/// - Search Mode: Single-line, search icon, compact design
/// - Tester Mode: Multi-line, no icon, expanded design
///
/// Styling Features:
/// - Consistent with app theme colors
/// - Responsive border and focus states
/// - Appropriate padding and spacing
/// - Google Fonts integration for typography
class SearchField extends StatelessWidget {
  /// Creates a [SearchField] widget.
  ///
  /// The widget provides sensible defaults while allowing extensive
  /// customization through its parameters. Most parameters are optional,
  /// making it easy to create simple search fields or complex input
  /// areas as needed.
  ///
  /// Parameters:
  /// - [onTap]: Callback for field tap events
  /// - [onChanged]: Callback for text change events
  /// - [showCursor]: Whether to display the text cursor
  /// - [readOnly]: Whether the field is read-only
  /// - [isTester]: Whether to use tester mode (multi-line)
  /// - [controller]: Text editing controller for the field
  const SearchField({
    this.onTap,
    this.onChanged,
    this.showCursor = true,
    this.readOnly = false,
    this.isTester = false,
    this.controller,
    super.key,
  });

  /// Callback function that is executed when the field is tapped.
  ///
  /// This callback is triggered when the user taps on the text field.
  /// It's useful for implementing custom tap behavior, such as showing
  /// a keyboard, opening a picker, or performing other tap-related actions.
  ///
  /// If not specified, no action is taken when the field is tapped.
  /// The callback receives no parameters and should handle the tap
  /// action appropriately for the specific use case.
  final void Function()? onTap;

  /// Whether to display the text cursor in the field.
  ///
  /// This parameter controls the visibility of the text cursor (caret)
  /// in the input field. When true, the cursor is visible and users
  /// can see where they're typing. When false, the cursor is hidden.
  ///
  /// Setting this to false is useful for read-only fields or when
  /// you want to hide the cursor for aesthetic reasons. The default
  /// value is true for normal text input behavior.
  final bool showCursor;

  /// Whether the text field is read-only.
  ///
  /// When true, the field displays text but doesn't allow editing.
  /// Users can still select and copy text, but they cannot modify
  /// the content. This is useful for displaying information or
  /// creating non-editable input areas.
  ///
  /// When false (default), the field behaves normally and allows
  /// full text editing capabilities. The field maintains its visual
  /// appearance regardless of this setting.
  final bool readOnly;

  /// Callback function that is executed when the text content changes.
  ///
  /// This callback is triggered whenever the user types, deletes, or
  /// otherwise modifies the text content. It receives the current
  /// text value as a parameter, allowing for real-time processing
  /// of user input.
  ///
  /// Common use cases include:
  /// - Search functionality (filtering results as user types)
  /// - Input validation (checking format or content)
  /// - Real-time updates (updating UI based on input)
  /// - Character counting or analysis
  ///
  /// If not specified, no action is taken when text changes.
  final void Function(String)? onChanged;

  /// The text editing controller for managing the field's content.
  ///
  /// This controller provides programmatic control over the text field's
  /// content, selection, and cursor position. It's useful for:
  /// - Setting initial text content
  /// - Programmatically updating the field
  /// - Clearing the field content
  /// - Managing text selection
  /// - Listening to text changes
  ///
  /// If not specified, the field creates its own internal controller.
  /// When provided, the controller should be properly managed (created
  /// and disposed) by the parent widget.
  final TextEditingController? controller;

  /// Controls the height and hint of the field (tester mode).
  ///
  /// This boolean parameter determines the operating mode of the field:
  /// - false (default): Single-line search mode with compact design
  /// - true: Multi-line tester mode with expanded design
  ///
  /// In tester mode, the field:
  /// - Supports multiple lines of text input
  /// - Has increased height and padding
  /// - Shows different hint text
  /// - Removes the search icon
  /// - Uses different styling appropriate for text input
  ///
  /// This mode is particularly useful for the multilingual tester
  /// where users need to enter longer text content for testing.
  final bool isTester;

  @override
  Widget build(BuildContext context) {
    final locale = context.appLocalizations;
    return TextField(
      showCursor: showCursor,
      onTap: onTap,
      onChanged: onChanged,
      controller: controller,
      readOnly: readOnly,
      maxLines: isTester ? 5 : 1, // Multi-line for tester mode
      keyboardType: TextInputType.multiline,
      autofillHints: const [AutofillHints.name],
      cursorColor: Colors.blue.shade400,
      style: GoogleFonts.notoSans(
        color: Colors.black,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        fillColor: AppTheme.searchColor,
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.whiteShade),
          borderRadius: BorderRadius.circular(8),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: AppTheme.whiteShade),
          borderRadius: BorderRadius.circular(8),
        ),
        contentPadding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical:
              isTester ? 10 : 0, // Increased vertical padding for tester mode
        ),
        hintText:
            !isTester ? 'Search by name or code' : locale.enterTextOrCharacters,
        hintStyle: TextStyle(
          fontFamily: GoogleFonts.notoSans().fontFamily,
          color: isTester
              ? Colors.grey
              : Colors.black, // Different hint color for tester mode
          fontSize: 16,
        ),
        prefixIcon: !isTester
            ? Icon(
                size: 20,
                color: Colors.blue.shade300,
                Icons.search) // Search icon only in search mode
            : null,
      ),
    );
  }
}
