import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';
import '../models/leaderboard_models.dart';

class LeaderboardRankingRow extends StatelessWidget {
  const LeaderboardRankingRow({super.key, required this.entry});

  final LeaderboardEntry entry;

  @override
  Widget build(BuildContext context) {
    final isCurrent = entry.isCurrentUser;

    return Container(
      height: AppDimensions.rankingRowHeight,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: isCurrent ? AppColors.primaryLight : AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        border: Border.all(
          color: isCurrent ? AppColors.primary : AppColors.white,
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 20,
            child: CustomText(
              '${entry.rank}',
              style: AppTextStyles.scenarioTitle.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Container(
            width: AppDimensions.avatarSizeSm,
            height: AppDimensions.avatarSizeSm,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.white, width: 2),
            ),
            child: CustomText(
              entry.initials,
              style: AppTextStyles.scenarioTitle.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  entry.name,
                  style: AppTextStyles.rankingName,
                  maxLines: 1,
                ),
                if (isCurrent)
                  CustomText(
                    AppStrings.youKeepClimbing,
                    style: AppTextStyles.currentUserHint,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
          SizedBox(
            width: 25,
            child: CustomText(
              '${entry.quizCount}',
              style: AppTextStyles.rankingMeta,
            ),
          ),
          SizedBox(
            width: 38,
            child: CustomText(
              entry.pointsLabel,
              style: AppTextStyles.rankingPoints,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
