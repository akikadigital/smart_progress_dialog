import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:smart_progress_dialog/util/dialog_assets.dart';

import 'enums.dart';

class SmartProgressDialog {
  /// Show a loading dialog with optional text.
  static void showProgressDialog(
    BuildContext context, {
    color = Colors.teal,
    String? text,
  }) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }
    _createSmartProgressDialogWidget(
      context,
      state: SmartProgressState.loading,
      text: text,
      autoDismiss: false,
    );
  }

  /// Stop the progress dialog and show a success, error, or warning state.
  static void dismissProgressDialog(
    BuildContext context, {
    SmartProgressState? state,
    String? text,
  }) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    if (text != null || state != null) {
      _createSmartProgressDialogWidget(
        context,
        state: state ?? SmartProgressState.success,
        text: text,
        autoDismiss: true,
      );
    }
  }

  /// Show a dialog with the specified state and optional text.
  static void _createSmartProgressDialogWidget(
    BuildContext context, {
    SmartProgressState state = SmartProgressState.loading,
    Color color = Colors.teal,
    Color backgroundColor = Colors.white,
    String? text,
    bool autoDismiss = true,
  }) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return SmartProgressDialogWidget(
          state: state,
          color: color,
          backgroundColor: backgroundColor,
          text: text,
          autoDismiss: autoDismiss,
        );
      },
    );
  }
}

/// A customizable dialog widget to show loading, success, failure, or warning states.
class SmartProgressDialogWidget extends StatefulWidget {
  final SmartProgressState state;
  final double size;
  final Color color;
  final Color backgroundColor;
  final String? text;
  final bool autoDismiss;

  const SmartProgressDialogWidget({
    Key? key,
    this.state = SmartProgressState.loading,
    this.size = 80.0,
    this.color = Colors.teal,
    this.backgroundColor = Colors.white,
    this.text,
    this.autoDismiss = true,
  }) : super(key: key);

  @override
  State<SmartProgressDialogWidget> createState() =>
      _SmartProgressDialogWidgetState();
}

class _SmartProgressDialogWidgetState extends State<SmartProgressDialogWidget> {
  late SmartProgressState currentState;

  @override
  void initState() {
    super.initState();
    currentState = widget.state;

    if (widget.autoDismiss && currentState != SmartProgressState.loading) {
      Timer(const Duration(seconds: 3), () {
        if (mounted) Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    Color? textColor;
    switch (currentState) {
      case SmartProgressState.loading:
        textColor = widget.color;
        content = SizedBox(
          width: widget.size,
          height: widget.size,
          child: Column(
            children: [
              const SizedBox(height: 16),
              CircularProgressIndicator(
                strokeWidth: 4,
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
        break;
      case SmartProgressState.success:
        textColor = Colors.green;
        content = Lottie.asset(
          DialogAssets.success,
          package: DialogAssets.package,
          width: widget.size,
          height: widget.size,
        );
        break;
      case SmartProgressState.error:
        textColor = Colors.red;
        content = Lottie.asset(
          DialogAssets.error,
          package: DialogAssets.package,
          width: widget.size,
          height: widget.size,
        );
        break;
      case SmartProgressState.warning:
        textColor = Colors.orange;
        content = Lottie.asset(
          DialogAssets.warning,
          package: DialogAssets.package,
          width: widget.size,
          height: widget.size,
        );
        break;
      case SmartProgressState.info:
        textColor = Colors.blue;
        // TODO: Handle this case.
        content = Lottie.asset(
          DialogAssets.info,
          package: DialogAssets.package,
          width: widget.size,
          height: widget.size,
        );
        break;
      default:
        textColor = widget.color;
        content = const SizedBox.shrink();
    }

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      backgroundColor: widget.backgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            content,
            if (widget.text != null && widget.text!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                widget.text!,
                style: TextStyle(color: textColor, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
