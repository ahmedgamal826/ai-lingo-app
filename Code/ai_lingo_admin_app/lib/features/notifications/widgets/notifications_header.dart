import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets_core/custom_text.dart';

class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({
    super.key,
    required this.onMarkAllRead,
  });

  final VoidCallback onMarkAllRead;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 68.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      color: AppColors.white,
      child: Row(
        children: [
          CustomText(
            text: 'Notifications',
            fontSize: 21.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
          const Spacer(),
          GestureDetector(
            onTap: onMarkAllRead,
            child: SvgPicture.asset(
              AppAssets.icon('check-check.svg'),
              width: 20.w,
              height: 20.w,
              colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
            ),
          ),
        ],
      ),
    );
  }
}

