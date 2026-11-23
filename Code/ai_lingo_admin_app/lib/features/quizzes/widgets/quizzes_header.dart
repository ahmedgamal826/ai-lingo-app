import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import 'quiz_svg_icon.dart';

/// "Quizzes / PLAN, PUBLISH, AND REVIEW" with a search icon on the right.
class QuizzesHeader extends StatelessWidget {
  const QuizzesHeader({super.key, this.onSearchTap});

  final VoidCallback? onSearchTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quizzes',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'PLAN, PUBLISH, AND REVIEW',
                style: TextStyle(
                  fontSize: 9.sp,
                  letterSpacing: 0.6,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          onPressed: onSearchTap,
          icon: QuizSvgIcon('search', size: 22.w, color: AppColors.primary),
        ),
      ],
    );
  }
}