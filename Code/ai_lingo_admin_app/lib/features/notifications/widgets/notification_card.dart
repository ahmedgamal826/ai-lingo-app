import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets_core/custom_card.dart';
import '../widgets_core/custom_text.dart';
import 'notification_data.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.data,
    required this.onTap,
  });

  final NotificationData data;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tinted = data.unread;
    return CustomCard(
      onTap: onTap,
      elevation: 0,
      padding: EdgeInsets.fromLTRB(12.w, 12.h, 12.w, 10.h),
      backgroundColor: tinted ? const Color(0xFFEEF0FF) : AppColors.white,
      borderRadius: BorderRadius.circular(15.r),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppAssets.icon(data.icon),
            width: 17.w,
            height: 17.w,
            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          SizedBox(width: 9.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: data.title,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
                SizedBox(height: 3.h),
                CustomText(
                  text: data.category,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primary,
                ),
                SizedBox(height: 5.h),
                CustomText(
                  text: data.description,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.w400,
                  color: AppColors.textSecondary,
                  maxLines: 2,
                ),
                SizedBox(height: 5.h),
                CustomText(
                  text: '${data.date} ┬╖ ${data.unread ? 'Unread' : data.type == 'Important' ? 'Important' : 'Read'}',
                  fontSize: 9.sp,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
          if (data.unread)
            Container(
              width: 6.w,
              height: 6.w,
              margin: EdgeInsets.only(top: 2.h, left: 5.w),
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }
}
