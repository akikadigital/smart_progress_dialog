import 'package:flutter/material.dart';

import 'enums.dart';

class SmartSnackBar {
  static void show(
    BuildContext context,
    String message, {
    String? title,
    SmartSnackBarType type = SmartSnackBarType.success,
    SmartSnackBarDuration duration = SmartSnackBarDuration.short,
    Color? backgroundColor,
    SmartSnackBarPosition position = SmartSnackBarPosition.bottom,
    bool showIcon = true,
    IconData? customIcon,
    bool showCloseIcon = false,
    Color closeIconColor = Colors.white,
    SnackBarClosedReason? Function()? onClose,
  }) {
    final overlay = Overlay.of(context);

    final color = backgroundColor ?? getColor(type);
    final iconData = customIcon ?? _getIconData(type);
    final durationMs = getDuration(duration).inMilliseconds;

    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        return __SmartSnackBarOverlay(
          title: title,
          message: message,
          icon: showIcon ? iconData : null,
          backgroundColor: color,
          position: position,
          showCloseIcon: showCloseIcon,
          closeIconColor: closeIconColor,
          onClose: () {
            overlayEntry.remove();
            if (onClose != null) onClose();
          },
        );
      },
    );

    overlay.insert(overlayEntry);

    if (!showCloseIcon) {
      Future.delayed(Duration(milliseconds: durationMs), () {
        if (overlayEntry.mounted) overlayEntry.remove();
        if (onClose != null) onClose();
      });
    }
  }

  static IconData _getIconData(SmartSnackBarType type) {
    switch (type) {
      case SmartSnackBarType.success:
        return Icons.check_circle;
      case SmartSnackBarType.error:
        return Icons.error;
      case SmartSnackBarType.warning:
        return Icons.warning;
      default:
        return Icons.info;
    }
  }

  static Duration getDuration(SmartSnackBarDuration duration) {
    switch (duration) {
      case SmartSnackBarDuration.long:
        return const Duration(seconds: 5);
      case SmartSnackBarDuration.indefinite:
        return const Duration(days: 365);
      default:
        return const Duration(seconds: 3);
    }
  }

  static Color getColor(SmartSnackBarType type) {
    switch (type) {
      case SmartSnackBarType.success:
        return Colors.green;
      case SmartSnackBarType.error:
        return Colors.red;
      case SmartSnackBarType.warning:
        return Colors.orange;
      default:
        return Colors.teal;
    }
  }
}

class __SmartSnackBarOverlay extends StatefulWidget {
  final String message;
  final String? title;
  final IconData? icon;
  final Color backgroundColor;
  final SmartSnackBarPosition position;
  final bool showCloseIcon;
  final Color closeIconColor;
  final VoidCallback? onClose;

  const __SmartSnackBarOverlay({
    Key? key,
    required this.message,
    this.title,
    this.icon,
    required this.backgroundColor,
    required this.position,
    this.showCloseIcon = false,
    this.closeIconColor = Colors.white,
    this.onClose,
  }) : super(key: key);

  @override
  State<__SmartSnackBarOverlay> createState() => __SmartSnackBarOverlayState();
}

class __SmartSnackBarOverlayState extends State<__SmartSnackBarOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _offsetAnimation = Tween<Offset>(
      begin: widget.position == SmartSnackBarPosition.top
          ? const Offset(0, -1)
          : const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final top = widget.position == SmartSnackBarPosition.top;
    return Positioned(
      top: top ? 50 : null,
      bottom: top ? null : 16,
      left: 16,
      right: 16,
      child: SafeArea(
        child: SlideTransition(
          position: _offsetAnimation,
          child: Material(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(12),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  if (widget.icon != null) ...[
                    Icon(widget.icon, color: Colors.white),
                    const SizedBox(width: 12),
                  ],
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (widget.title != null)
                          Text(
                            widget.title!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                        Text(
                          widget.message,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  if (widget.showCloseIcon)
                    IconButton(
                      icon: Icon(Icons.close, color: widget.closeIconColor),
                      onPressed: widget.onClose,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
