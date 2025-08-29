/// A button widget that provides tactile feedback through shrink animation.
///
/// The ShrinkableButton is a custom button implementation that creates a
/// satisfying tactile experience by animating the button's scale when pressed.
/// It uses Flutter's animation system to smoothly scale down the button
/// on press and scale it back up when released.
///
/// This widget is particularly useful for interactive elements that benefit
/// from visual feedback, such as:
/// - Custom buttons and interactive cards
/// - Font selection boxes
/// - Tool selection interfaces
/// - Any clickable element that should provide tactile feedback
///
/// Key Features:
/// - Smooth scale animation on press and release
/// - Configurable animation duration and curve
/// - Proper gesture handling for various touch scenarios
/// - Automatic cleanup of animation resources
/// - Support for any child widget content
library;

import 'package:flutter/material.dart';

/// A button that provides tactile feedback through scale animation.
///
/// This widget wraps any child widget and adds press animation behavior.
/// When pressed, the button smoothly scales down to 80% of its original size,
/// then scales back up when released. The animation uses a bounce curve
/// for a more engaging user experience.
///
/// The button handles various touch scenarios:
/// - onTapDown: Scales down immediately
/// - onTapUp: Scales back up when finger is lifted
/// - onTapCancel: Scales back up if touch is cancelled
/// - onTap: Executes the callback after a short delay
///
/// The delay before executing the callback ensures the scale animation
/// completes before the action is performed, providing better visual feedback.
class ShrinkableButton extends StatefulWidget {
  /// Creates a [ShrinkableButton].
  ///
  /// The [child] parameter is required and represents the content to display
  /// inside the button. The [onTap] callback is optional but typically
  /// provided to handle the button press action.
  const ShrinkableButton({required this.child, super.key, this.onTap});

  /// The widget to display inside the button.
  ///
  /// This can be any Flutter widget, such as text, icons, images, or
  /// complex layouts. The child will be animated along with the button
  /// container during press interactions.
  final Widget child;

  /// Callback function that is executed when the button is tapped.
  ///
  /// This function is called after the press animation completes, ensuring
  /// that users see the full visual feedback before the action is performed.
  /// If null, no action will be taken when the button is tapped.
  final VoidCallback? onTap;

  /// Creates the mutable state for this widget.
  @override
  State<ShrinkableButton> createState() => _ShrinkableButtonState();
}

/// The state class for the ShrinkableButton widget.
///
/// This class manages the animation controller and handles the scale
/// animation logic. It implements SingleTickerProviderStateMixin to
/// provide the vsync capability needed for the animation controller.
class _ShrinkableButtonState extends State<ShrinkableButton>
    with SingleTickerProviderStateMixin {
  /// Animation controller for managing the scale animation.
  ///
  /// This controller manages the animation lifecycle and provides
  /// the current animation value for the scale transformation.
  late AnimationController _controller;

  /// Curved animation that applies a bounce effect to the scale animation.
  ///
  /// The bounce curve makes the animation more engaging and provides
  /// a more natural feel to the button press interaction.
  late CurvedAnimation _curvedAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller with a 100ms duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
      value: 1, // Start at full scale (100%)
      lowerBound: 0.8, // Scale down to 80% when pressed
    );

    // Apply a bounce curve to make the animation more engaging
    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceIn,
    );

    // Listen to animation changes to trigger rebuilds
    _controller.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //tag: 'shrinkable-button',
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,

        // Scale down when finger touches the button
        onTapDown: (_) {
          _controller.reverse(); // Animate to lower bound (0.8)
        },

        // Scale back up when finger is lifted
        onTapUp: (_) {
          _controller.forward(); // Animate back to full scale (1.0)
        },

        // Scale back up if touch is cancelled
        onTapCancel: () {
          _controller.forward(); // Animate back to full scale (1.0)
        },

        // Execute the callback after animation completes
        onTap: () {
          // Delay execution to allow animation to complete
          Future.delayed(const Duration(milliseconds: 200), () {
            widget.onTap?.call();
          });
        },

        // Apply the scale transformation based on animation value
        child: Transform.scale(
          scale: _curvedAnimation.value,
          child: widget.child,
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the animation controller to prevent memory leaks
    _controller.dispose();
    super.dispose();
  }
}
