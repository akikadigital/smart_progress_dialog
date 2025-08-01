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
    String? text,
    double size = 80,
    Color color = Colors.teal,
    Color backgroundColor = Colors.white,
    bool autoDismiss = true, // <--- New
  }) {
    if (_context == null) return;

    showDialog(
      context: _context!,
      barrierDismissible: false,
      builder: (_) => SmartProgressDialogWidget(
        state: state,
        text: text,
        size: size,
        color: color,
        backgroundColor: backgroundColor,
        autoDismiss: autoDismiss, // <-- pass it
      ),
    );
  }

  /// Show a loading spinner.
  void showLoading([String? text]) {
    show(state: SmartProgressState.loading, text: text);
  }

  /// Show a success animation and dismiss automatically.
  void showSuccess({
    required String text,
    Color? color,
    bool autoDismiss = true,
  }) {
    show(
      state: SmartProgressState.success,
      text: text,
      color: color ?? Colors.green,
      autoDismiss: autoDismiss,
    );
    if (autoDismiss) _autoDismiss();
  }

  /// Show a success animation and dismiss automatically.
  void showInfo({
    required String text,
    Color? color,
    bool autoDismiss = true,
  }) {
    show(
      state: SmartProgressState.info,
      text: text,
      color: color ?? Colors.blue,
      autoDismiss: autoDismiss,
    );
    if (autoDismiss) _autoDismiss();
  }

  /// Show a warning animation and dismiss automatically.
  void showWarning({
    required String text,
    Color? color,
    bool autoDismiss = true,
  }) {
    show(
      state: SmartProgressState.warning,
      text: text,
      color: color ?? Colors.orange,
      autoDismiss: autoDismiss,
    );
    if (autoDismiss) _autoDismiss();
  }

  /// Show a failure animation and dismiss automatically.
  void showFailure({
    required String text,
    Color? color,
    bool autoDismiss = true,
  }) {
    show(
      state: SmartProgressState.error,
      text: text,
      color: color ?? Colors.red,
      autoDismiss: autoDismiss,
    );
    if (autoDismiss) _autoDismiss();
  }

  /// Manually dismiss the dialog.
  void dismiss() {
    if (_context != null && Navigator.canPop(_context!)) {
      Navigator.of(_context!, rootNavigator: true).pop();
    }
  }

  /// Automatically dismiss the dialog after a short delay.
  void _autoDismiss() {
    Future.delayed(const Duration(seconds: (3)), () {
      dismiss();
    });
  }
}
