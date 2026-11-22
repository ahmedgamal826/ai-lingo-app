import 'package:ai_lingo_admin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    super.key,
    required this.text,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
    this.padding,
    this.height,
    this.letterSpacing,
  });
  final String text;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;
  final EdgeInsetsGeometry? padding;

  /// Line height multiplier (e.g. 1.4 = 140%).
  final double? height;
  final double? letterSpacing;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final responsiveFontSize =
        fontSize ??
        (screenWidth > 600.w
            ? 16.sp
            : screenWidth > 400.w
            ? 14.sp
            : 12.sp);

    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Inter',
          // Before: `Colors.black ?? ...` -> the `color` parameter was ignored.
          color: color ?? AppColors.textPrimary,
          fontSize: responsiveFontSize,
          fontWeight: fontWeight,
          height: height,
          letterSpacing: letterSpacing,
        ),
        overflow: TextOverflow.ellipsis,
        maxLines: maxLines ?? 3,
        textAlign: textAlign,
      ),
    );
  }
}
