import 'package:flutter/material.dart';

/// A loading indicator widget designed for use at the bottom of a scrolling list,
/// typically when implementing infinite scroll behavior.
class SmartListLoader extends StatelessWidget {
  /// Whether the loader should be visible.
  final bool isLoading;

  /// The size of the circular loader.
  final double size;

  /// The color of the progress indicator.
  final Color color;

  const SmartListLoader({
    Key? key,
    required this.isLoading,
    this.size = 32,
    this.color = Colors.teal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: SizedBox(
          width: size,
          height: size,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
      ),
    );
  }
}
