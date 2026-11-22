import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_text.dart';

class NotificationSectionHeader extends StatelessWidget {
  const NotificationSectionHeader({
    super.key,
    required this.onMarkAllRead,
  });

  final VoidCallback onMarkAllRead;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(
          text: 'Your admin inbox',
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.textPrimary,
        ),
        GestureDetector(
          onTap: onMarkAllRead,
          child: CustomText(
            text: 'Mark all read',
            fontSize: 11.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}

