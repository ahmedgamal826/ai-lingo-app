import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import 'custom_card.dart';
import '../models/quiz_models.dart';
import 'quiz_avatar.dart';
import 'quiz_svg_icon.dart';

/// One learner row: avatar, name + details, score, and an edit pencil.
/// Adjusted learners get a soft blue background.
class QuizLearnerResultTile extends StatelessWidget {
  const QuizLearnerResultTile({
    super.key,
    required this.learner,
    required this.onEdit,
  });

  final QuizLearnerResult learner;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final highlighted = learner.isAdjusted;

    return CustomCard(
      backgroundColor: highlighted ? AppColors.primaryLight : AppColors.white,
      elevation: highlighted ? AppDimensions.elevationNone : null,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      child: Row(
        children: [
          QuizAvatar(
            learner.initials,
            size: 34,
            backgroundColor:
            highlighted ? AppColors.white : AppColors.primaryLight,
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  learner.name,
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  learner.detail,
                  style: TextStyle(
                    fontSize: 9.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '${learner.score}',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.primary,
            ),
          ),
          SizedBox(width: 6.w),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onEdit,
            child: Padding(
              padding: EdgeInsets.all(4.w),
              child: QuizSvgIcon('pencil', size: 16.w, color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}