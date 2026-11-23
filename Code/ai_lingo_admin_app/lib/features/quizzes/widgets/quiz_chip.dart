import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

/// Small blue pill: "Week 46" or "STEP 1 OF 3 · QUIZ DETAILS".
class QuizChip extends StatelessWidget {
  const QuizChip(this.label, {super.key, this.letterSpacing = 0});

  final String label;
  final double letterSpacing;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 9.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: letterSpacing,
          color: AppColors.primary,
        ),
      ),
    );
  }
}