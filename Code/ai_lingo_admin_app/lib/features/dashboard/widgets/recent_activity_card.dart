import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../models/dashboard_models.dart';

/// One white card that contains all the activity rows.
class RecentActivityCard extends StatelessWidget {
  const RecentActivityCard({super.key, required this.activities, this.onTap});

  final List<DashboardActivity> activities;
  final ValueChanged<DashboardActivity>? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          for (var i = 0; i < activities.length; i++) ...[
            if (i > 0) SizedBox(height: 12.h),
            _ActivityRow(
              activity: activities[i],
              onTap: onTap == null ? null : () => onTap!(activities[i]),
            ),
          ],
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.activity, this.onTap});

  final DashboardActivity activity;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(activity.icon, size: 18.w, color: AppColors.primary),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  activity.subtitle,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Icon(Icons.chevron_right, size: 18.w, color: AppColors.textSecondary),
        ],
      ),
    );
  }
}