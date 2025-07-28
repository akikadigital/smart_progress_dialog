import 'package:flutter/material.dart';

import 'dialog_state.dart';

/// A customizable snackbar utility for quick user feedback.
class SmartSnackBar {
  static void show(
    BuildContext context,
    String message, {
    SmartProgressState state = SmartProgressState.success,
    Duration duration = const Duration(seconds: 3),
    Color? backgroundColor,
    SnackBarBehavior behavior = SnackBarBehavior.floating,
    SnackBarAction? action,
    SnackBarClosedReason? Function()? onClose,
    SnackBarPosition position = SnackBarPosition.bottom,
  }) {
    Color defaultColor;
    switch (state) {
      case SmartProgressState.success:
        defaultColor = Colors.green;
        break;
      case SmartProgressState.failure:
        defaultColor = Colors.red;
        break;
      case SmartProgressState.warning:
        defaultColor = Colors.orange;
        break;
      default:
        defaultColor = Colors.teal;
    }

    final snackBar = SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor ?? defaultColor,
      duration: duration,
      behavior: behavior,
      action: action,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: position == SnackBarPosition.top
          ? const EdgeInsets.fromLTRB(16, 50, 16, 0)
          : const EdgeInsets.fromLTRB(16, 0, 16, 16),
    );

    /// Show the snackbar at the bottom or top of the screen based on position.
    /// Allows showing a number of snackbars at the same time.
    ScaffoldMessenger.of(context)
        .showSnackBar(snackBar)
        .closed
        .then((SnackBarClosedReason reason) {
      ;
      if (onClose != null) {
        onClose();
      }
    });
  }
}

/// Enum for snackbar position.
enum SnackBarPosition {
  top,
  bottom,
}
