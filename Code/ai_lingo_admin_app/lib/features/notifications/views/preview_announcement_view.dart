import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../widgets_core/custom_button.dart';
import '../widgets_core/custom_card.dart';
import '../widgets_core/custom_text.dart';
import 'announcement_sent_view.dart';

class PreviewAnnouncementView extends StatelessWidget {
  const PreviewAnnouncementView({
    super.key,
    required this.title,
    required this.message,
    required this.category,
    required this.priority,
  });

  final String title;
  final String message;
  final String category;
  final String priority;

  Widget _iconBox(String asset, {double size = 18}) => Container(
        width: 36.w,
        height: 36.w,
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(10.r),
        ),
        alignment: Alignment.center,
        child: SvgPicture.asset(
          AppAssets.icon(asset),
          width: size.w,
          height: size.w,
          colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 62.h,
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              color: AppColors.white,
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context).pop(),
                    borderRadius: BorderRadius.circular(24.r),
                    child: Padding(
                      padding: EdgeInsets.all(6.w),
                      child: Icon(Icons.arrow_back, size: 20.w, color: AppColors.textPrimary),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  CustomText(
                    text: 'Preview Announcement',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.fromLTRB(20.w, 18.h, 20.w, 20.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "Here's how your announcement will look to learners.",
                      fontSize: 13.sp,
                      color: AppColors.textSecondary,
                      maxLines: 2,
                    ),
                    SizedBox(height: 14.h),
                    CustomCard(
                      elevation: 0,
                      backgroundColor: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(20.r),
                      padding: EdgeInsets.all(14.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                AppAssets.icon('megaphone.svg'),
                                width: 22.w,
                                height: 22.w,
                                colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
                              ),
                              const Spacer(),
                              CustomText(
                                text: priority,
                                fontSize: 9.sp,
                                color: AppColors.purple,
                                fontWeight: FontWeight.w600,
                              ),
                            ],
                          ),
                          SizedBox(height: 14.h),
                          CustomText(
                            text: title,
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                            maxLines: 3,
                          ),
                          SizedBox(height: 12.h),
                          CustomText(
                            text: message,
                            fontSize: 12.sp,
                            color: AppColors.textPrimary,
                            maxLines: 5,
                          ),
                          SizedBox(height: 12.h),
                          CustomText(
                            text: 'AI-Lingo ┬╖ $category ┬╖ Nov 12, 9:00 AM',
                            fontSize: 9.sp,
                            color: AppColors.textSecondary,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    CustomCard(
                      elevation: 0,
                      backgroundColor: AppColors.white,
                      borderRadius: BorderRadius.circular(18.r),
                      padding: EdgeInsets.all(14.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              _iconBox('users-round.svg'),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: 'All users', fontSize: 12.sp, fontWeight: FontWeight.w600),
                                    SizedBox(height: 3.h),
                                    CustomText(text: '1,248 learners will be notified', fontSize: 10.sp, color: AppColors.textSecondary),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              _iconBox('bell.svg'),
                              SizedBox(width: 10.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(text: 'Send immediately', fontSize: 12.sp, fontWeight: FontWeight.w600),
                                    SizedBox(height: 3.h),
                                    CustomText(text: 'In-app notification ┬╖ $priority priority', fontSize: 10.sp, color: AppColors.textSecondary, maxLines: 2),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 14.h),
                    CustomCard(
                      elevation: 0,
                      backgroundColor: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(14.r),
                      padding: EdgeInsets.all(12.w),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(AppAssets.icon('info.svg'), width: 17.w, height: 17.w, colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn)),
                          SizedBox(width: 10.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(text: 'Ready to share?', fontSize: 11.sp, fontWeight: FontWeight.w600),
                                SizedBox(height: 5.h),
                                CustomText(text: 'Review your message before sending. This action cannot be undone.', fontSize: 11.sp, color: AppColors.textSecondary, maxLines: 3),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 84.h),
                    SizedBox(
                      width: double.infinity,
                      child: CustomDarkButton(
                        text: 'Send to All Users',
                        iconWidget: SvgPicture.asset(
                          AppAssets.icon('send.svg'),
                          width: 16.w,
                          height: 16.w,
                          colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                        ),
                        width: double.infinity,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute<void>(
                              builder: (_) => AnnouncementSentView(
                                title: title,
                                message: message,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 12.h),
                    SizedBox(
                      width: double.infinity,
                      child: CustomLightButton(
                        text: 'Edit Announcement',
                        width: double.infinity,
                        onTap: () => Navigator.of(context).pop(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
