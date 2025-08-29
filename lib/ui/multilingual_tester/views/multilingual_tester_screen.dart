/// Multilingual tester screen for the Unicode Flutter App.
///
/// This screen allows users to input text, automatically detect the script/font
/// family,
/// select from available fonts for that script, and preview how the text
/// renders
/// in different font styles. It's designed to help users test and compare
/// multilingual text rendering across various font families.
///
/// Key Features:
/// - Real-time text input with automatic script detection
/// - Dynamic font family selection based on detected script
/// - Live preview of text rendering in selected fonts
/// - Support for multiple Unicode scripts and font families
/// - Responsive UI with proper state management using Flutter Hooks
library;

import 'package:auto_route/auto_route.dart';
import 'package:dart_icu4x/dart_icu4x.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsoc_unicode_app/app/app_theme.dart';
import 'package:gsoc_unicode_app/shared/shared.dart';
import 'package:gsoc_unicode_app/ui/ui.dart';
import 'package:gsoc_unicode_app/utils/utils.dart';

/// The main multilingual tester screen widget.
///
/// This widget provides a comprehensive interface for testing multilingual text
/// rendering. It automatically detects the script of the input text and
/// provides appropriate font options for that script. Users can preview how
/// their text looks in different font families, making it easier to choose the
/// right font for multilingual content.
///
/// The screen includes:
/// - A text input field for entering test content
/// - Automatic script detection and font family suggestions
/// - Font selection interface with visual feedback
/// - Real-time preview of text rendering in selected fonts
/// - Support for both single font and "all fonts" preview modes
@RoutePage()
class MultilingualTesterScreen extends HookWidget {
  /// Creates a [MultilingualTesterScreen].
  const MultilingualTesterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Get localized strings for the current locale
    final locale = context.appLocalizations;

    // Text editing controller for the input field
    final controller = useTextEditingController();

    // State variables managed by Flutter Hooks
    final currentText = useState<String>(''); // Current text input value
    final selectedIndex =
        useState<int>(0); // Index of selected font (0 = All fonts)
    final scriptName = useState<String>(''); // Detected Unicode script name
    final availableScriptFonts =
        useState<int>(0); // Count of available fonts for script
    final isScriptDetected =
        useState<bool>(false); // Whether script was successfully detected

    return Scaffold(
      backgroundColor: AppTheme.screenShade,
      appBar: CustomAppBar(title: locale.multilingualTester),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),

            // Section title for text input
            Text(
              locale.textToCompare,
              style: GoogleFonts.notoSans(
                fontSize: 16,
                color: Colors.black,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 16),

            /// Input field for text to compare
            ///
            /// This field accepts multilingual text input and triggers script
            /// detection on text changes. The onChanged callback updates the
            /// current text state and performs script detection to determine
            /// appropriate font options.
            SearchField(
              isTester: true,
              controller: controller,
              onChanged: (value) {
                // Update the current text state for real-time UI updates
                currentText.value = value;

                if (value.isNotEmpty) {
                  // Detect the Unicode script for the first character
                  final script = getScriptForChar(ch: value.trim()[0]);
                  scriptName.value = script;
                  isScriptDetected.value = script.isNotEmpty;

                  // Count available fonts for the detected script
                  availableScriptFonts.value =
                      UnicodeHelper.getFontStylesForScript(scriptName.value)
                          .length;
                } else {
                  // Reset all state when text is cleared
                  scriptName.value = '';
                  isScriptDetected.value = false;
                  availableScriptFonts.value = 0;
                  selectedIndex.value = 0;
                }
              },
            ),

            // Font selection and preview section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Section title for font selection
                Text(
                  !isScriptDetected.value ? locale.font : 'Fonts',
                  style: GoogleFonts.notoSans(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),

                /// Font selection interface
                ///
                /// Displays available font options based on the detected
                /// script.
                /// Shows "All" option to preview text in all available fonts,
                /// or individual font family options for the specific script.
                Column(
                  children: [
                    Wrap(
                      spacing: 10,
                      runSpacing: 10,
                      children: [
                        // Show font options only when text is present and
                        //script is detected
                        if (currentText.value.isNotEmpty &&
                            isScriptDetected.value) ...[
                          // "All fonts" option - shows text in all available
                          // fonts
                          FontBox(
                            fontName: 'All',
                            isSelected: selectedIndex.value == 0,
                            onTap: () => selectedIndex.value = 0,
                          ),

                          // Individual font family options for the detected
                          // script
                          ...UnicodeHelper.getFontStylesForScript(
                                  scriptName.value)
                              .map((style) {
                            final index = UnicodeHelper.getFontStylesForScript(
                                    scriptName.value)
                                .indexOf(style);
                            return FontBox(
                              fontName:
                                  style.fontFamily?.split('_').toList().first ??
                                      'System Default',
                              isSelected: selectedIndex.value == index + 1,
                              onTap: () => selectedIndex.value = index + 1,
                            );
                          })
                        ],

                        // Default font option when no text is entered
                        if (currentText.value.isEmpty)
                          FontBox(
                            fontName: 'System Default',
                            isSelected: true,
                            onTap: () => selectedIndex.value = 0,
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // Text rendering preview section
                if (currentText.value.isNotEmpty) ...[
                  Text(
                    locale.renderingPreview,
                    style: GoogleFonts.notoSans(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Preview content based on script detection and font
                  // selection
                  if (!isScriptDetected.value)
                    // Show text in default style when script cannot be detected
                    _TextDisplayField(
                      text: currentText.value,
                      style: const TextStyle(),
                    )
                  else if (isScriptDetected.value) ...[
                    if (selectedIndex.value == 0)
                      // Show text in all available fonts for the script
                      Column(
                        spacing: 20,
                        children: UnicodeHelper.getFontStylesForScript(
                                scriptName.value)
                            .map((style) => _TextDisplayField(
                                  text: currentText.value,
                                  style: style,
                                ))
                            .toList(),
                      )
                    else
                      // Show text in the specifically selected font
                      _TextDisplayField(
                        text: currentText.value,
                        style: UnicodeHelper.getFontStylesForScript(
                            scriptName.value)[selectedIndex.value - 1],
                      ),
                    const SizedBox(height: 24),
                  ],
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A widget that displays text content with a specific font style.
///
/// This widget shows both the font family name and the actual text content
/// rendered in the specified style. It's used to demonstrate how different
/// font families render the same text content.
///
/// Parameters:
/// - [text]: The text content to display
/// - [style]: The TextStyle to apply to the text content
class _TextDisplayField extends StatelessWidget {
  /// Creates a [_TextDisplayField] widget.
  const _TextDisplayField({
    required this.text,
    required this.style,
  });

  /// The text content to display and render.
  final String text;

  /// The text style to apply, including font family, size, and other
  /// properties.
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 23,
        horizontal: 15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppTheme.whiteShade),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the font family name in blue
          Text(
            style.fontFamily?.split('_').toList().first ?? 'System Default',
            maxLines: 2,
            style: style.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 14),

          // Display the actual text content in the specified style
          Text(
            text,
            style: style.copyWith(
              fontSize: 16,
              color: Colors.black87,
            ),
            softWrap: true,
            overflow: TextOverflow.visible,
          ),
        ],
      ),
    );
  }
}
