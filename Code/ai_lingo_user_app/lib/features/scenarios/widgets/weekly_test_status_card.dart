import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/weekly_test_models.dart';

class WeeklyTestStatusCard extends StatelessWidget {
  const WeeklyTestStatusCard({
    super.key,
    required this.status,
    required this.title,
    required this.description,
    required this.countdown,
    required this.endedAtLabel,
  });

  final WeeklyTestStatus status;
  final String title;
  final String description;
  final Duration countdown;
  final String endedAtLabel;

  WeeklyTestStatusStyle get _style {
    switch (status) {
      case WeeklyTestStatus.locked:
        return const WeeklyTestStatusStyle(
          badgeLabel: AppStrings.badgeLocked,
          badgeBackground: AppColors.warningLight,
          badgeForeground: AppColors.warning,
          statusIconAsset: AppAssets.lockKeyhole,
          countdownLabel: AppStrings.opensIn,
        );
      case WeeklyTestStatus.active:
        return const WeeklyTestStatusStyle(
          badgeLabel: AppStrings.badgeActive,
          badgeBackground: AppColors.successLight,
          badgeForeground: AppColors.success,
          statusIconAsset: AppAssets.clipboardCheck,
          countdownLabel: AppStrings.closesIn,
        );
      case WeeklyTestStatus.closed:
        return const WeeklyTestStatusStyle(
          badgeLabel: AppStrings.badgeClosed,
          badgeBackground: AppColors.errorLight,
          badgeForeground: AppColors.danger,
          statusIconAsset: AppAssets.circleCheck,
          countdownLabel: AppStrings.testEnded,
        );
    }
  }

  String get _countdownValue {
    if (status == WeeklyTestStatus.closed) return endedAtLabel;
    final days = countdown.inDays.toString().padLeft(2, '0');
    final hours = (countdown.inHours % 24).toString().padLeft(2, '0');
    final minutes = (countdown.inMinutes % 60).toString().padLeft(2, '0');
    return '${days}d  ${hours}h  ${minutes}m';
  }

  @override
  Widget build(BuildContext context) {
    final style = _style;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXxl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08263166),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(style.statusIconAsset, width: 29, height: 29),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
                decoration: BoxDecoration(
                  color: style.badgeBackground,
                  borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
                ),
                child: CustomText(
                  style.badgeLabel,
                  style: AppTextStyles.quizBadge.copyWith(
                    color: style.badgeForeground,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(title, style: AppTextStyles.weeklyTestTitle, maxLines: 2),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(
            description,
            style: AppTextStyles.bodySecondary,
            maxLines: 3,
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(
            style.countdownLabel,
            style: AppTextStyles.weeklyTestCountdownLabel,
          ),
          const SizedBox(height: 3),
          CustomText(
            _countdownValue,
            style: AppTextStyles.weeklyTestCountdownValue,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
