import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

/// Circle with the learner's initials ("SR", "AC"...).
class QuizAvatar extends StatelessWidget {
  const QuizAvatar(
      this.initials, {
        super.key,
        this.size = 36,
        this.backgroundColor = AppColors.primaryLight,
      });

  final String initials;
  final double size;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.w,
      height: size.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Text(
        initials,
        style: TextStyle(
          fontSize: 10.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
        ),
      ),
    );
  }
}