import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_text.dart';

class AnnouncementSentView extends StatelessWidget {
  const AnnouncementSentView({super.key, required this.title, required this.message});

  final String title;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 62.h,
              width: double.infinity,
              color: AppColors.white,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.icon('circle-check.svg'),
                    width: 18.w,
                    height: 18.w,
                    colorFilter: const ColorFilter.mode(AppColors.success, BlendMode.srcIn),
                  ),
                  SizedBox(width: 10.w),
                  CustomText(
                    text: 'Announcement sent',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 76.w,
                      height: 76.w,
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        AppAssets.icon('send.svg'),
                        width: 34.w,
                        height: 34.w,
                        colorFilter: const ColorFilter.mode(AppColors.success, BlendMode.srcIn),
                      ),
                    ),
                    SizedBox(height: 18.h),
                    CustomText(
                      text: 'A message that matters.',
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textPrimary,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12.h),
                    CustomText(
                      text: '“$title” has been sent to all \n 1,248 learners.',
                      fontSize: 12.sp,
                      color: AppColors.textSecondary,
                      textAlign: TextAlign.center,
              ),
                    SizedBox(height: 20.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: AppColors.successLight,
                        borderRadius: BorderRadius.circular(14.r),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            AppAssets.icon('circle-check.svg'),
                            width: 15.w,
                            height: 15.w,
                            colorFilter: const ColorFilter.mode(AppColors.success, BlendMode.srcIn),
                          ),
                          SizedBox(width: 9.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'All set',
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textPrimary,
                                ),
                                SizedBox(height: 5.h),
                                CustomText(
                                  text: 'Sent Nov 12, 2026 at 9:00 AM. Your announcement is now visible in learner notifications.',
                                  fontSize: 11.sp,
                                  color: AppColors.textSecondary,
                                  maxLines: 3,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 18.h),
              child: SizedBox(
                width: double.infinity,
                child: CustomDarkButton(
                  text: 'Back to Dashboard',
                  width: double.infinity,
                  onTap: () => Navigator.of(context).popUntil((route) => route.isFirst),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
