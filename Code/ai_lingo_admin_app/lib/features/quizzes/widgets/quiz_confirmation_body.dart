import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import 'quiz_action_button.dart';
import 'quiz_svg_icon.dart';

/// Shared body for the confirmation screens (Quiz published, Score updated):
/// icon in a rounded square, title, message, optional extra widget,
/// and a bottom button.
class QuizConfirmationBody extends StatelessWidget {
  const QuizConfirmationBody({
    super.key,
    required this.iconName,
    required this.title,
    required this.message,
    required this.buttonLabel,
    required this.onButtonTap,
    this.child,
  });

  final String iconName;
  final String title;
  final String message;
  final String buttonLabel;
  final VoidCallback onButtonTap;

  /// Optional widget shown under the message (e.g. the "All set" banner).
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 86.w,
                        height: 86.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: AppColors.successLight,
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        child: QuizSvgIcon(
                          iconName,
                          size: 36.w,
                          color: AppColors.success,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 11.sp,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      if (child != null) ...[
                        SizedBox(height: 20.h),
                        child!,
                      ],
                    ],
                  ),
                ),
              ),
            ),
            QuizActionButton.primary(label: buttonLabel, onTap: onButtonTap),
          ],
        ),
      ),
    );
  }
}