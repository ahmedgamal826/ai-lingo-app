import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import 'quiz_svg_icon.dart';

/// Label + white dropdown with an SVG chevron (string items only).
class QuizDropdown extends StatelessWidget {
  const QuizDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            border: Border.all(color: AppColors.indicatorInactive),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: value,
              isExpanded: true,
              dropdownColor: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
              icon: QuizSvgIcon(
                'chevron-down',
                size: 18.w,
                color: AppColors.textSecondary,
              ),
              style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary),
              items: [
                for (final item in items)
                  DropdownMenuItem<String>(value: item, child: Text(item)),
              ],
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}