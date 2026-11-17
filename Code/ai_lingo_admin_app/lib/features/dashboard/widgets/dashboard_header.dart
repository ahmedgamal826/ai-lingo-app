import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

class DashboardHeader extends StatelessWidget {
  const DashboardHeader({super.key, this.onBellTap});

  final VoidCallback? onBellTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'AI-LINGO · ADMIN WORKSPACE',
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
          onPressed: onBellTap,
          icon: const Icon(
            Icons.notifications_none_rounded,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}