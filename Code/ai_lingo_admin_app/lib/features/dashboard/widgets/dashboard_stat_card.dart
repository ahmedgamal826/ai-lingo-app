import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../core/widgets/custom_card.dart';
import '../models/dashboard_models.dart';
import 'dashboard_svg_icon.dart';

/// White stat card: SVG icon, big value, title, optional green caption.
/// Same look as `CustomCard.stat`, but with an SVG icon.
class DashboardStatCard extends StatelessWidget {
  const DashboardStatCard({super.key, required this.stat});

  final DashboardStat stat;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardSvgIcon(
            stat.iconName,
            size: AppDimensions.iconMd,
            color: AppColors.primary,
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          Text(
            stat.value,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(
            stat.title,
            style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
          ),
          if (stat.caption != null) ...[
            const SizedBox(height: AppDimensions.spaceXs),
            Text(
              stat.caption!,
              style: TextStyle(fontSize: 11.sp, color: AppColors.success),
            ),
          ],
        ],
      ),
    );
  }
}