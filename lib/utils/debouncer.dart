/// A utility class for debouncing function calls.
///
/// The Debouncer class provides a mechanism to delay the execution of a
/// function
/// until a specified amount of time has passed since the last call. This is
/// particularly useful for scenarios like search input fields, where you want
/// to avoid making API calls on every keystroke.
///
/// When a function is called through the debouncer, it cancels any pending
/// execution and schedules a new one after the specified delay. This ensures
/// that only the most recent call is executed, reducing unnecessary function
/// calls and improving performance.
///
/// Common Use Cases:
/// - Search input fields (delay API calls until user stops typing)
/// - Window resize handlers (delay expensive calculations)
/// - Scroll event handlers (limit scroll-based updates)
/// - Form validation (delay validation until user stops typing)
///
/// Example Usage:
/// ```dart
/// final debouncer = Debouncer(delay: Duration(milliseconds: 500));
///
/// // This will cancel the previous call and schedule a new one
/// debouncer.run(() => performSearch(query));
///
/// // Don't forget to dispose when done
/// debouncer.dispose();
/// ```
library;

import 'dart:async';

import 'package:flutter/material.dart';

/// {@template debouncer}
/// A utility class that debounces function calls by delaying execution.
///
/// The debouncer ensures that a function is only called after a specified
/// delay has passed since the last call. If a new call is made before the
/// delay expires, the previous call is cancelled and a new delay timer
/// is started.
/// {@endtemplate}
class Debouncer {
  /// {@macro debouncer}
  ///
  /// Creates a new debouncer with the specified delay duration.
  ///
  /// The [delay] parameter determines how long to wait after the last
  /// call before executing the function. A longer delay means fewer
  /// function calls but more waiting time.
  Debouncer({
    required this.delay,
  });

  /// The delay duration before executing the debounced function.
  ///
  /// This value determines how long the debouncer waits after the last
  /// call before executing the function. Choose an appropriate delay
  /// based on your use case:
  /// - Short delays (100-300ms) for responsive UI updates
  /// - Medium delays (500-1000ms) for search inputs
  /// - Longer delays (1000ms+) for expensive operations
  final Duration delay;

  /// The internal timer used to track the delay period.
  ///
  /// This timer is managed internally and should not be accessed
  /// directly. It's automatically cancelled and recreated as needed.
  Timer? _timer;

  /// Executes a function after the specified delay, cancelling any pending
  /// execution.
  ///
  /// This method cancels any previously scheduled function execution and
  /// schedules a new one after the specified delay. If called multiple times
  /// before the delay expires, only the most recent call will be executed.
  ///
  /// Parameters:
  /// - [callback]: The function to execute after the delay
  ///
  /// Returns:
  /// - A [Timer] object that can be used to cancel the execution if needed
  ///
  /// Example:
  /// ```dart
  /// final timer = debouncer.run(() => print('Executed after delay'));
  ///
  /// // Cancel the execution if needed
  /// timer.cancel();
  /// ```
  Timer run(VoidCallback callback) {
    // Cancel any existing timer to prevent multiple executions
    _timer?.cancel();

    // Create a new timer with the specified delay
    _timer = Timer(delay, callback);

    // Return the timer so the caller can cancel it if needed
    return _timer!;
  }

  /// Cancels any pending function execution and cleans up resources.
  ///
  /// This method should be called when the debouncer is no longer needed
  /// to prevent memory leaks and ensure proper cleanup. It cancels any
  /// pending timer and releases the timer reference.
  ///
  /// It's good practice to call this method in the dispose method of
  /// StatefulWidgets or when cleaning up resources.
  void dispose() => _timer?.cancel();
}
