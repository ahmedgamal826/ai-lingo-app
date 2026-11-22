import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/widgets/custom_card.dart';
import 'quiz_avatar.dart';

/// White card at the top of "Adjust Score": avatar, name, email,
/// current score, and a small ticket tag.
class QuizLearnerHeaderCard extends StatelessWidget {
  const QuizLearnerHeaderCard({
    super.key,
    required this.initials,
    required this.name,
    required this.email,
    required this.currentScore,
    this.tag,
  });

  final String initials;
  final String name;
  final String email;
  final int currentScore;

  /// e.g. "#C-1042"
  final String? tag;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              QuizAvatar(initials, size: 36),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      email,
                      style: TextStyle(
                        fontSize: 9.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Current score: $currentScore/100',
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ),
              if (tag != null)
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
                  decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
                  ),
                  child: Text(
                    tag!,
                    style: TextStyle(
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}