import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import 'home_scale.dart';

class DailyMomentumCard extends StatelessWidget {
  const DailyMomentumCard({
    super.key,
    required this.streakLabel,
    required this.progressLabel,
    required this.progressPercentLabel,
    required this.progress,
    this.onStartPracticing,
  });

  final String streakLabel;
  final String progressLabel;
  final String progressPercentLabel;
  final double progress;
  final VoidCallback? onStartPracticing;

  @override
  Widget build(BuildContext context) {
    final radius = homeScale(context, AppDimensions.radiusXxl);
    final padding = homeScale(context, AppDimensions.paddingMd);
    final gap = homeScale(context, 10);
    final buttonHeight = homeScale(context, AppDimensions.buttonHeightSm);
    final iconSize = homeScale(context, AppDimensions.icon18);
    final barHeight = homeScale(context, AppDimensions.progressBarHeight);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08263166),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: CustomCard(
        elevation: AppDimensions.elevationNone,
        backgroundColor: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(radius),
        padding: EdgeInsets.all(padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: CustomText(
                    AppStrings.dailyMomentumTitle,
                    style: AppTextStyles.cardTitle.copyWith(
                      fontSize: homeScale(
                        context,
                        AppTextStyles.cardTitle.fontSize!,
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: homeScale(context, 9),
                    vertical: homeScale(context, 5),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningLight,
                    borderRadius: BorderRadius.circular(
                      homeScale(context, AppDimensions.radiusSm),
                    ),
                  ),
                  child: CustomText(
                    streakLabel,
                    style: AppTextStyles.streakBadge.copyWith(
                      fontSize: homeScale(
                        context,
                        AppTextStyles.streakBadge.fontSize!,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: gap),
            Row(
              children: [
                Expanded(
                  child: CustomText(
                    progressLabel,
                    style: AppTextStyles.bodySecondary.copyWith(
                      fontSize: homeScale(
                        context,
                        AppTextStyles.bodySecondary.fontSize!,
                      ),
                    ),
                  ),
                ),
                CustomText(
                  progressPercentLabel,
                  style: AppTextStyles.progressPercent.copyWith(
                    fontSize: homeScale(
                      context,
                      AppTextStyles.progressPercent.fontSize!,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: gap),
            ClipRRect(
              borderRadius: BorderRadius.circular(homeScale(context, 10)),
              child: SizedBox(
                height: barHeight,
                child: LinearProgressIndicator(
                  value: progress.clamp(0.0, 1.0),
                  minHeight: barHeight,
                  backgroundColor: AppColors.indicatorInactive,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                ),
              ),
            ),
            SizedBox(height: gap),
            SizedBox(
              width: double.infinity,
              height: buttonHeight,
              child: Material(
                color: AppColors.primary,
                borderRadius: BorderRadius.circular(
                  homeScale(context, AppDimensions.radiusButton),
                ),
                child: InkWell(
                  onTap: onStartPracticing,
                  borderRadius: BorderRadius.circular(
                    homeScale(context, AppDimensions.radiusButton),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.sparkles,
                        width: iconSize,
                        height: iconSize,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                      SizedBox(
                        width: homeScale(context, AppDimensions.spaceSm),
                      ),
                      CustomText(
                        AppStrings.startPracticing,
                        style: AppTextStyles.buttonLabel.copyWith(
                          fontSize: homeScale(
                            context,
                            AppTextStyles.buttonLabel.fontSize!,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
