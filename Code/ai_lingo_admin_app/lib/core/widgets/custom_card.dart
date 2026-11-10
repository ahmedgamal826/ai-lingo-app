import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.elevation,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final double? elevation;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius =
        borderRadius ?? BorderRadius.circular(AppDimensions.radiusMd);

    return Material(
      color: backgroundColor,
      elevation: elevation ?? AppDimensions.elevationSm,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMd),
          decoration: BoxDecoration(borderRadius: radius, border: border),
          child: child,
        ),
      ),
    );
  }
}
