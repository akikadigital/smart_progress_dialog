import 'package:flutter/material.dart';
import 'package:smart_progress_dialog/smart_progress_dialog.dart';

/// Controller to manage the SmartProgressDialog lifecycle and state transitions.
class SmartProgressController {
  BuildContext? _context;

  /// Attach the controller to a BuildContext for showing dialogs.
  void attach(BuildContext context) {
    _context = context;
  }

  /// Detach the controller from the current context.
  void detach() {
    _context = null;
  }

  /// Show a custom dialog with the given parameters.
  void show({
    SmartProgressState state = SmartProgressState.loading,
    String? message,
    double size = 80,
    Color color = Colors.teal,
    Color backgroundColor = Colors.white,
  }) {
    if (_context == null) return;

    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (_) => SmartProgressDialog(
        state: state,
        message: message,
        size: size,
        color: color,
        backgroundColor: backgroundColor,
      ),
    );
  }

  /// Show a loading spinner.
  void showLoading([String? message]) {
    show(state: SmartProgressState.loading, message: message);
  }

  /// Show a success animation and dismiss automatically.
  void showSuccess([String? message]) {
    show(state: SmartProgressState.success, message: message);
    _autoDismiss();
  }

  /// Show a failure animation and dismiss automatically.
  void showFailure([String? message]) {
    show(state: SmartProgressState.failure, message: message);
    _autoDismiss();
  }

  /// Show a warning animation and dismiss automatically.
  void showWarning([String? message]) {
    show(state: SmartProgressState.warning, message: message);
    _autoDismiss();
  }

  /// Manually dismiss the dialog.
  void dismiss() {
    if (_context != null && Navigator.canPop(_context!)) {
      Navigator.of(_context!, rootNavigator: true).pop();
    }
  }

  /// Automatically dismiss the dialog after a short delay.
  void _autoDismiss() {
    Future.delayed(const Duration(seconds: 3), () {
      dismiss();
    });
  }
}
