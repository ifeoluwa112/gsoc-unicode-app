/// A widget that displays a tool option with comprehensive information and
/// interaction.
///
/// The ToolBox widget is a reusable component that displays information about
/// available tools in the app. It provides a clean, card-like interface with
/// an icon, title, description, and navigation indicator. The widget is
/// designed to be used on the home screen for tool selection.
///
/// Each ToolBox represents a single tool option and provides:
/// - Visual icon representation of the tool
/// - Clear title for tool identification
/// - Descriptive text explaining the tool's purpose
/// - Touch interaction for navigation
/// - Visual feedback through the ShrinkableButton wrapper
///
/// Key Features:
/// - Clean, card-based design with rounded corners
/// - Icon-based visual identification
/// - Descriptive text for user understanding
/// - Touch interaction with shrink animation
/// - Navigation arrow indicator
/// - Responsive layout that adapts to content
/// - Consistent styling with app theme
///
/// Usage:
/// ```dart
/// ToolBox(
///   tool: 'Unicode Character Visualizer',
///   description: 'Explore and visualize Unicode characters',
///   icon: Icons.search,
///   onTap: () => navigateToVisualizer(),
/// )
/// ```
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsoc_unicode_app/app/app_theme.dart';
import 'package:gsoc_unicode_app/shared/shared.dart';
import 'package:gsoc_unicode_app/utils/utils.dart';

/// A widget that displays a tool option with icon, title, and description.
///
/// This widget creates a card-like interface for displaying tool options
/// on the home screen. It combines visual elements (icon, title, description)
/// with interactive functionality (touch handling, navigation) to provide
/// users with clear information about available tools and easy access to them.
///
/// Design Features:
/// - White background with subtle borders
/// - Rounded corners for modern appearance
/// - Icon container with themed background
/// - Clear typography hierarchy
/// - Navigation arrow for user guidance
/// - Consistent spacing and alignment
///
/// Interaction:
/// - Wrapped in ShrinkableButton for tactile feedback
/// - Full-width touch target for easy interaction
/// - Clear visual hierarchy for information scanning
/// - Smooth animations and transitions
class ToolBox extends StatelessWidget {
  /// Creates a [ToolBox] widget.
  ///
  /// All parameters are required to ensure proper widget configuration
  /// and display. The widget automatically handles layout and styling
  /// based on the provided information.
  ///
  /// Parameters:
  /// - [tool]: The name/title of the tool
  /// - [description]: A brief description of what the tool does
  /// - [icon]: The icon that represents the tool
  /// - [onTap]: Callback function for handling tool selection
  const ToolBox({
    required this.tool,
    required this.description,
    required this.icon,
    required this.onTap,
    super.key,
  });

  /// The name or title of the tool.
  ///
  /// This text is displayed prominently in the tool box and serves
  /// as the primary identifier for the tool. It should be concise
  /// but descriptive enough for users to understand what the tool
  /// does at a glance.
  ///
  /// Examples:
  /// - "Unicode Character Visualizer"
  /// - "Multilingual Tester"
  /// - "Font Comparison Tool"
  final String tool;

  /// A brief description of the tool's functionality.
  ///
  /// This text provides additional context about what the tool does
  /// and helps users understand whether it meets their needs. The
  /// description should be informative but concise, typically one
  /// or two lines long.
  ///
  /// Examples:
  /// - "Explore and visualize Unicode characters with detailed information"
  /// - "Test text rendering in different fonts and scripts"
  /// - "Compare font families and rendering quality"
  final String description;

  /// The icon that visually represents the tool.
  ///
  /// This icon is displayed in a themed container and provides
  /// immediate visual recognition of the tool's purpose. The icon
  /// should be semantically appropriate for the tool's functionality
  /// and consistent with the app's iconography.
  ///
  /// Common icons:
  /// - Icons.search for search/exploration tools
  /// - Icons.language for multilingual tools
  /// - Icons.font_download for font-related tools
  /// - Icons.visibility for visualization tools
  final IconData icon;

  /// Callback function that is executed when the tool box is tapped.
  ///
  /// This function handles the user's selection of the tool and
  /// typically performs navigation to the tool's interface or
  /// initiates the tool's functionality. The callback receives
  /// no parameters and should handle the tool selection action
  /// appropriately.
  ///
  /// Common actions:
  /// - Navigate to tool screen
  /// - Open tool modal/dialog
  /// - Initialize tool functionality
  /// - Show tool information
  final VoidCallback onTap;

  /// Builds the widget tree for the tool box.
  ///
  /// This method creates the complete visual structure of the tool
  /// box, including the container, icon, text content, and navigation
  /// indicator. The layout is designed to be responsive and provide
  /// clear visual hierarchy for easy scanning and interaction.
  ///
  /// Layout Structure:
  /// - Full-width container with padding and borders
  /// - Left: Icon in themed container
  /// - Center: Title and description text
  /// - Right: Navigation arrow indicator
  ///
  /// Returns:
  /// - A complete tool box widget with all visual elements
  @override
  Widget build(BuildContext context) {
    return ShrinkableButton(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppTheme.whiteShade),
        ),
        child: Row(
          children: [
            // Icon container with themed background
            Container(
              height: 50,
              width: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppTheme.blueShade,
              ),
              child: Icon(icon, size: 40, color: Colors.blue),
            ),
            const SizedBox(width: 17),

            // Text content area (title and description)
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Tool title with consistent typography
                  Text(
                    tool,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.notoSans(
                      textStyle: context.textTheme.displayLarge?.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),

                  // Tool description with overflow handling
                  Text(
                    description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 17),

            // Navigation arrow indicator
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
