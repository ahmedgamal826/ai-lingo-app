import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import 'quiz_svg_icon.dart';

/// Soft blue card that sums up the quiz before it is scheduled.
class QuizSummaryCard extends StatelessWidget {
  const QuizSummaryCard({
    super.key,
    required this.title,
    required this.details,
    required this.note,
  });

  final String title;

  /// e.g. "Week 47 · B1 · 20 questions · 20 minutes"
  final String details;

  /// Green line at the bottom, e.g. "All questions have a correct answer".
  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            details,
            style: TextStyle(fontSize: 10.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              QuizSvgIcon('check-check', size: 12.w, color: AppColors.success),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  note,
                  style: TextStyle(fontSize: 10.sp, color: AppColors.success),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}