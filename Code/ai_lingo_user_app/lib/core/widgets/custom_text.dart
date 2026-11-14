import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.data, {
    super.key,
    this.style,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.padding,
  });

  final String data;
  final TextStyle? style;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.sizeOf(context).width;
    final responsiveFontSize =
        fontSize ??
        style?.fontSize ??
        (screenWidth > 600
            ? 16.0
            : screenWidth > 400
            ? 14.0
            : 12.0);

    final resolvedStyle = (style ?? const TextStyle()).copyWith(
      fontFamily: style?.fontFamily ?? 'Inter',
      color: color ?? style?.color ?? AppColors.textPrimary,
      fontSize: responsiveFontSize,
      fontWeight: fontWeight ?? style?.fontWeight,
    );

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        data,
        style: resolvedStyle,
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 3,
        textAlign: textAlign,
      ),
    );
  }
}
