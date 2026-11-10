import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.color,
    this.backgroundColor,
    this.size = AppDimensions.iconMd,
    this.isEnabled = true,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final Color? color;
  final Color? backgroundColor;
  final double size;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    final button = IconButton(
      onPressed: isEnabled ? onPressed : null,
      icon: Icon(icon, size: size),
      color: color,
      style: IconButton.styleFrom(backgroundColor: backgroundColor),
    );

    if (tooltip == null) return button;
    return Tooltip(message: tooltip!, child: button);
  }
}
