/// A selectable font box widget for the multilingual tester.
///
/// This widget displays a font family name in a clickable container that can be
/// selected or deselected. When selected, it shows a visual indicator
/// (checkmark) and changes its appearance to indicate the current selection
/// state.
///
/// The widget is designed to be used in the font selection interface where
/// users can choose which font family to preview their text in. It provides
/// clear visual feedback about the current selection state and supports touch
/// interactions through the ShrinkableButton wrapper.
///
/// Key Features:
/// - Visual selection state indication
/// - Touch feedback with shrink animation
/// - Consistent styling with the app theme
/// - Support for both selected and unselected states
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsoc_unicode_app/app/app_theme.dart';
import 'package:gsoc_unicode_app/shared/shrinkable_button.dart';

/// A selectable font box widget that displays a font family name.
///
/// This widget represents a single font option in the font selection interface.
/// It can be in either a selected or unselected state, with visual indicators
/// for each state. The widget is wrapped in a ShrinkableButton to provide
/// tactile feedback when tapped.
///
/// The widget automatically adjusts its appearance based on the selection
/// state:
/// - Selected: Blue background with white text and checkmark icon
/// - Unselected: White background with black text and border
class FontBox extends StatelessWidget {
  /// Creates a [FontBox] widget.
  ///
  /// All parameters are required to ensure proper widget configuration.
  const FontBox({
    required this.fontName,
    required this.onTap,
    this.isSelected = false,
    super.key,
  });

  /// The name of the font family to display.
  ///
  /// This text is shown to the user and should be a human-readable
  /// representation of the font family (e.g., "Noto Sans", "Arial").
  final String fontName;

  /// Whether this font box is currently selected.
  ///
  /// When true, the widget displays with a blue background, white text,
  /// and a checkmark icon. When false, it displays with a white background,
  /// black text, and a border.
  final bool isSelected;

  /// Callback function that is executed when the font box is tapped.
  ///
  /// This function should handle the selection logic, typically updating
  /// the parent widget's state to reflect the new selection.
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ShrinkableButton(
      onTap: onTap,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          // Dynamic color based on selection state
          color: !isSelected ? Colors.white : Colors.blue,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            bottomLeft: Radius.circular(20),
            topRight: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
          // Border only shown when not selected
          border: Border.all(
              color: !isSelected ? AppTheme.whiteShade : Colors.transparent),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                // Font family name text
                Text(
                  fontName,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.notoSans(
                    fontSize: 14,
                    // Dynamic text color based on selection state
                    color: isSelected ? Colors.white : Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                // Checkmark icon shown only when selected
                if (isSelected) ...[
                  const SizedBox(width: 8),
                  // Circular white background for the checkmark
                  Container(
                    width: 15,
                    height: 15,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      // Small checkmark icon in black
                      child: Icon(
                        Icons.check,
                        size: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}
