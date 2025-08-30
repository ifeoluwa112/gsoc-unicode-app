/// Splash screen for the Unicode Flutter App (Home module).
///
/// The SplashScreen is the initial screen displayed when the app starts.
/// It provides an engaging animated introduction to the app with smooth
/// transitions and visual effects before navigating to the main application.
///
/// This screen serves multiple purposes:
/// - Brand introduction and recognition
/// - App initialization time management
/// - User engagement through animations
/// - Smooth transition to main app functionality
///
/// Key Features:
/// - Multiple layered animations (slide, fade, scale, rotation)
/// - Background color pulsing effect
/// - Automatic navigation after animation completion
/// - Responsive design that works on various screen sizes
/// - Consistent styling with the app theme
///
/// Animation Details:
/// - Text animations: 2-second duration with elastic curves
/// - Background animation: 3-second looping pulse effect
/// - Navigation delay: 3.5 seconds total display time
/// - Smooth transitions using Flutter's animation system
///
/// Usage:
/// ```dart
/// // Automatically displayed on app startup
/// // No manual instantiation required
/// ```
library;

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gsoc_unicode_app/app/app_router.dart';
import 'package:gsoc_unicode_app/app/app_theme.dart';
import 'package:gsoc_unicode_app/utils/utils.dart';

/// The splash screen widget shown at app startup (from the home module).
///
/// This widget provides an engaging animated introduction to the app
/// with multiple layered animations that create a polished and
/// professional user experience. It automatically transitions to
/// the main app after the animation sequence completes.
///
/// The splash screen uses several animation controllers to create
/// complex visual effects:
/// - Text entrance animations (slide, fade, scale, rotation)
/// - Background color pulsing for visual interest
/// - Coordinated timing for smooth user experience
///
/// Animation Sequence:
/// 1. Text slides up from bottom with elastic effect
/// 2. Text fades in and scales up with rotation
/// 3. Background color pulses continuously
/// 4. After 3.5 seconds, navigates to main app
@RoutePage()
class SplashScreen extends StatefulWidget {
  /// Creates a [SplashScreen].
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// The state class for the SplashScreen widget.
///
/// This class manages all the animation controllers and coordinates
/// the complex animation sequence that creates the engaging splash
/// screen experience. It implements TickerProviderStateMixin to
/// provide the vsync capability needed for smooth animations.
///
/// Animation Management:
/// - Multiple animation controllers for different effects
/// - Coordinated timing for smooth transitions
/// - Automatic cleanup of animation resources
/// - Navigation timing based on animation completion
class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  /// Animation controller for text animations.
  ///
  /// This controller manages the main text animation sequence including
  /// slide, fade, scale, and rotation effects. It has a 2-second
  /// duration and uses elastic curves for engaging visual effects.
  late AnimationController _controller;

  /// Slide animation for text entrance effect.
  ///
  /// Creates a sliding effect where the text moves from below the
  /// screen to its final position. Uses an elastic curve for a
  /// bouncy, engaging entrance animation.
  late Animation<Offset> _slideAnimation;

  /// Fade animation for text opacity transition.
  ///
  /// Controls the text opacity from completely transparent to fully
  /// visible. Uses an ease-in curve for smooth fade-in effect.
  late Animation<double> _fadeAnimation;

  /// Scale animation for text size transition.
  ///
  /// Animates the text size from 50% to 100% of its final size.
  /// Uses an elastic curve for a bouncy scaling effect.
  late Animation<double> _scaleAnimation;

  /// Rotation animation for text orientation effect.
  ///
  /// Applies a subtle rotation effect to the text during entrance.
  /// Starts with a slight negative rotation and animates to normal
  /// orientation for added visual interest.
  late Animation<double> _rotationAnimation;

  /// Color animation for text color transition.
  ///
  /// Controls the text color transition (currently white to white
  /// but can be customized for different effects).
  late Animation<Color?> _colorAnimation;

  /// Background animation controller for color pulsing.
  ///
  /// This controller manages the continuous background color pulsing
  /// effect. It loops continuously with a 3-second duration to
  /// create visual interest throughout the splash screen display.
  late AnimationController _bgController;

  /// Background color animation for pulsing effect.
  ///
  /// Animates the background color between blue shades to create
  /// a subtle pulsing effect that adds visual interest without
  /// being distracting.
  late Animation<Color?> _bgColorAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize text animations controller with 2-second duration
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    );

    // Configure slide animation: text slides up from bottom
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 2), // Start below screen
      end: Offset.zero, // End at normal position
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Configure fade animation: text fades in smoothly
    _fadeAnimation = Tween<double>(
      begin: 0, // Start completely transparent
      end: 1, // End fully visible
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    // Configure scale animation: text scales up with bounce
    _scaleAnimation = Tween<double>(
      begin: 0.5, // Start at 50% size
      end: 1, // End at full size
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    // Configure rotation animation: subtle rotation effect
    _rotationAnimation = Tween<double>(
      begin: -0.1, // Start with slight negative rotation
      end: 0, // End at normal orientation
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    // Configure color animation: text color transition
    _colorAnimation = ColorTween(
      begin: Colors.white, // Start color
      end: Colors.white, // End color (can be customized)
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    // Start the text animation sequence
    _controller.forward();

    // Initialize background pulse animation controller
    // This creates a continuous looping effect for visual interest
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // Loop continuously with reverse

    // Configure background color animation: pulsing between blue shades
    _bgColorAnimation = ColorTween(
      begin: Colors.blue.shade700, // Darker blue
      end: AppTheme.blueShade, // App theme blue
    ).animate(_bgController);

    // Schedule navigation to main app after animation completion
    // Total display time: 3.5 seconds (allows for animation completion)
    Future.delayed(const Duration(milliseconds: 3500), () {
      if (mounted) {
        context.router.replace(BaseRoute());
      }
    });
  }

  @override
  void dispose() {
    // Clean up animation controllers to prevent memory leaks
    _controller.dispose();
    _bgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = context.appLocalizations;
    return AnimatedBuilder(
      // Listen to both animation controllers for coordinated updates
      animation: Listenable.merge([_controller, _bgController]),
      builder: (context, child) {
        return Scaffold(
          // Animated background color for pulsing effect
          backgroundColor: _bgColorAnimation.value,
          body: Center(
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Transform.rotate(
                  angle: _rotationAnimation.value,
                  child: Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Text(
                      locale.unicode,
                      style: GoogleFonts.notoSans(
                        textStyle: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: _colorAnimation.value,
                          // Add shadow for depth and visual appeal
                          shadows: [
                            Shadow(
                              blurRadius: 10,
                              color: Colors.black.withValues(alpha: 0.3),
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
