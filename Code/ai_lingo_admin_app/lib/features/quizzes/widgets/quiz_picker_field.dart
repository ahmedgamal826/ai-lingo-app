import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import 'quiz_svg_icon.dart';

/// Small label + tappable white field that shows a date or a time.
class QuizPickerField extends StatelessWidget {
  const QuizPickerField({
    super.key,
    required this.label,
    required this.value,
    required this.iconName,
    required this.onTap,
  });

  final String label;
  final String value;

  /// SVG name from `assets/icons/` (e.g. 'calendar' or 'clock').
  final String iconName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppDimensions.radiusMd);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        Material(
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: const BorderSide(color: AppColors.indicatorInactive),
          ),
          child: InkWell(
            onTap: onTap,
            customBorder: RoundedRectangleBorder(borderRadius: radius),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 13.h),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value,
                      style: TextStyle(
                        fontSize: 11.sp,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ),
                  QuizSvgIcon(
                    iconName,
                    size: 16.w,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}