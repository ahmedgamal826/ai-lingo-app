import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../models/quiz_models.dart';
import 'quiz_svg_icon.dart';

/// One quiz row in the management list.
class QuizListCard extends StatelessWidget {
  const QuizListCard({super.key, required this.quiz, this.onTap});

  final Quiz quiz;
  final VoidCallback? onTap;

  static String _statusLabel(QuizStatus status) => switch (status) {
    QuizStatus.scheduled => 'Scheduled',
    QuizStatus.closed => 'Closed',
    QuizStatus.draft => 'Draft',
  };

  static CustomTone _statusTone(QuizStatus status) => switch (status) {
    QuizStatus.scheduled => CustomTone.info,
    QuizStatus.closed => CustomTone.neutral,
    QuizStatus.draft => CustomTone.warning,
  };

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                quiz.week,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              CustomStatusBadge(
                label: _statusLabel(quiz.status),
                tone: _statusTone(quiz.status),
              ),
            ],
          ),
          SizedBox(height: 6.h),
          Row(
            children: [
              Expanded(
                child: Text(
                  quiz.title,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
              ),
              QuizSvgIcon(
                'chevron-right',
                size: 18.w,
                color: AppColors.textSecondary,
              ),
            ],
          ),
          SizedBox(height: 4.h),
          Text(
            quiz.schedule,
            style: TextStyle(fontSize: 10.sp, color: AppColors.textSecondary),
          ),
          SizedBox(height: 4.h),
          Text(
            quiz.summary,
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.primary,
            ),
          ),
        ],
      ),
    );
  }
}