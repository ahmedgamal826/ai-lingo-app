import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';
import 'home_scale.dart';

class LearnerOverviewHeader extends StatelessWidget {
  const LearnerOverviewHeader({
    super.key,
    required this.initials,
    required this.greeting,
    required this.levelLabel,
    required this.rankLabel,
    required this.unreadCount,
    this.onNotificationsTap,
    this.onLeaderboardTap,
  });

  final String initials;
  final String greeting;
  final String levelLabel;
  final String rankLabel;
  final int unreadCount;
  final VoidCallback? onNotificationsTap;
  final VoidCallback? onLeaderboardTap;

  @override
  Widget build(BuildContext context) {
    final avatarSize = homeScale(context, AppDimensions.avatarSize);
    final bellSize = homeScale(context, AppDimensions.iconBell);
    final badgeSize = homeScale(context, AppDimensions.badgeSize);
    final trophySize = homeScale(context, AppDimensions.trophyRankSize);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: avatarSize,
          height: avatarSize,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
          ),
          child: CustomText(
            initials,
            style: AppTextStyles.avatarInitials.copyWith(
              fontSize: homeScale(
                context,
                AppTextStyles.avatarInitials.fontSize!,
              ),
            ),
          ),
        ),
        SizedBox(width: homeScale(context, AppDimensions.spaceMd)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                greeting,
                style: AppTextStyles.greeting.copyWith(
                  fontSize: homeScale(
                    context,
                    AppTextStyles.greeting.fontSize!,
                  ),
                ),
                maxLines: 1,
              ),
              SizedBox(height: homeScale(context, AppDimensions.spaceXs)),
              CustomText(
                levelLabel,
                style: AppTextStyles.caption.copyWith(
                  fontSize: homeScale(context, AppTextStyles.caption.fontSize!),
                ),
                maxLines: 1,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onLeaderboardTap,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                AppAssets.trophy,
                width: trophySize,
                height: trophySize,
              ),
              SizedBox(width: homeScale(context, 3)),
              CustomText(
                rankLabel,
                style: AppTextStyles.captionBold.copyWith(
                  fontSize: homeScale(
                    context,
                    AppTextStyles.captionBold.fontSize!,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: homeScale(context, AppDimensions.spaceSm)),
        GestureDetector(
          onTap: onNotificationsTap,
          child: SizedBox(
            width: bellSize + badgeSize * 0.55,
            height: bellSize,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Positioned(
                  left: 0,
                  top: 0,
                  child: SvgPicture.asset(
                    AppAssets.bell,
                    width: bellSize,
                    height: bellSize,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: badgeSize,
                    height: badgeSize,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppColors.danger,
                      shape: BoxShape.circle,
                    ),
                    child: CustomText(
                      '$unreadCount',
                      style: AppTextStyles.unreadBadge.copyWith(
                        fontSize: homeScale(
                          context,
                          AppTextStyles.unreadBadge.fontSize!,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
