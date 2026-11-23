import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import 'quiz_svg_icon.dart';

/// Full-width action button used across the quiz screens.
///
/// `.primary` = solid blue, `.light` = soft blue background.
class QuizActionButton extends StatelessWidget {
  const QuizActionButton.primary({
    super.key,
    required this.label,
    this.onTap,
    this.iconName,
  }) : filled = true;

  const QuizActionButton.light({
    super.key,
    required this.label,
    this.onTap,
    this.iconName,
  }) : filled = false;

  final String label;
  final VoidCallback? onTap;

  /// Optional SVG name from `assets/icons/` (e.g. 'plus').
  final String? iconName;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final foreground = filled ? AppColors.white : AppColors.primary;
    final radius = BorderRadius.circular(AppDimensions.radiusMd);

    return Material(
      color: filled ? AppColors.primary : AppColors.primaryLight,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: SizedBox(
          height: AppDimensions.buttonHeight,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (iconName != null) ...[
                QuizSvgIcon(iconName!, size: 18.w, color: foreground),
                SizedBox(width: 8.w),
              ],
              Text(
                label,
                style: TextStyle(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}