import 'package:flutter/material.dart';

/// A wrapper around [RefreshIndicator] with customizable color and background.
class SmartRefreshIndicator extends StatelessWidget {
  /// The widget below this indicator (e.g., a ListView).
  final Widget child;

  /// The refresh logic callback.
  final Future<void> Function() onRefresh;

  /// The color of the refresh spinner.
  final Color color;

  /// The background color of the refresh indicator.
  final Color backgroundColor;

  const SmartRefreshIndicator({
    Key? key,
    required this.child,
    required this.onRefresh,
    this.color = Colors.teal,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: color,
      backgroundColor: backgroundColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
