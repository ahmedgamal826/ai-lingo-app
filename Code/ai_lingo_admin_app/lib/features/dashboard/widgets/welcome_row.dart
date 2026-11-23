import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../core/widgets/custom_card.dart';

/// "JM  Good morning, Jamie / Monday, November 16   [Admin]"
class WelcomeRow extends StatelessWidget {
  const WelcomeRow({
    super.key,
    required this.initials,
    required this.title,
    required this.subtitle,
    this.roleLabel = 'Admin',
  });

  final String initials;
  final String title;
  final String subtitle;
  final String roleLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18.r,
          backgroundColor: AppColors.purpleLight,
          child: Text(
            initials,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.purple,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
        CustomStatusBadge(label: roleLabel, tone: CustomTone.purple),
      ],
    );
  }
}