import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'dialog_state.dart';

/// A customizable dialog widget to show loading, success, failure, or warning states.
class SmartProgressDialog extends StatefulWidget {
  final SmartProgressState state;
  final double size;
  final Color color;
  final Color backgroundColor;
  final String? message;

  const SmartProgressDialog({
    Key? key,
    this.state = SmartProgressState.loading,
    this.size = 80.0,
    this.color = Colors.teal,
    this.backgroundColor = Colors.white,
    this.message,
  }) : super(key: key);

  @override
  State<SmartProgressDialog> createState() => _SmartProgressDialogState();
}

class _SmartProgressDialogState extends State<SmartProgressDialog> {
  late SmartProgressState currentState;

  @override
  void initState() {
    super.initState();
    currentState = widget.state;

    if (currentState != SmartProgressState.loading) {
      Timer(const Duration(seconds: 3), () {
        if (mounted) Navigator.of(context, rootNavigator: true).pop();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    switch (currentState) {
      case SmartProgressState.loading:
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
        content = Lottie.asset(
          'assets/success_tick.json',
          width: widget.size,
          height: widget.size,
        );
        break;
      case SmartProgressState.failure:
        content = Lottie.asset(
          'assets/failure_x.json',
          width: widget.size,
          height: widget.size,
        );
        break;
      case SmartProgressState.warning:
        content = Lottie.asset(
          'assets/warning_alert.json',
          width: widget.size,
          height: widget.size,
        );
        break;
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
            if (widget.message != null && widget.message!.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                widget.message!,
                style: TextStyle(color: widget.color, fontSize: 14),
                textAlign: TextAlign.center,
              ),
            ]
          ],
        ),
      ),
    );
  }
}
