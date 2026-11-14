import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/leaderboard_models.dart';

class LeaderboardPodiumCard extends StatelessWidget {
  const LeaderboardPodiumCard({
    super.key,
    required this.caption,
    required this.topLearners,
  });

  final String caption;

  /// Expected order from state: [2nd, 1st, 3rd].
  final List<LeaderboardEntry> topLearners;

  @override
  Widget build(BuildContext context) {
    final second = topLearners[0];
    final first = topLearners[1];
    final third = topLearners[2];

    return CustomCard(
      elevation: AppDimensions.elevationNone,
      backgroundColor: AppColors.primaryLight,
      borderRadius: BorderRadius.circular(AppDimensions.podiumRadius),
      padding: const EdgeInsets.all(15),
      child: Column(
        children: [
          CustomText(
            caption,
            style: AppTextStyles.podiumCaption,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _PodiumLearner(
                  entry: second,
                  medalAsset: AppAssets.silverMedal,
                  topPadding: AppDimensions.spaceLg,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm),
              Expanded(
                child: _PodiumLearner(
                  entry: first,
                  medalAsset: AppAssets.goldMedal,
                ),
              ),
              const SizedBox(width: AppDimensions.spaceSm),
              Expanded(
                child: _PodiumLearner(
                  entry: third,
                  medalAsset: AppAssets.bronzeMedal,
                  topPadding: AppDimensions.spaceLg,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PodiumLearner extends StatelessWidget {
  const _PodiumLearner({
    required this.entry,
    required this.medalAsset,
    this.topPadding = 0,
  });

  final LeaderboardEntry entry;
  final String medalAsset;
  final double topPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: topPadding),
      child: Column(
        children: [
          Image.asset(
            medalAsset,
            width: AppDimensions.medalSize,
            height: AppDimensions.medalSize,
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 5),
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
          const SizedBox(height: 5),
          CustomText(
            entry.name,
            style: AppTextStyles.podiumName,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          CustomText(
            entry.podiumPointsLabel,
            style: AppTextStyles.meta,
            textAlign: TextAlign.center,
            maxLines: 1,
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
            ),
            child: CustomText(
              entry.quizBadgeLabel,
              style: AppTextStyles.quizBadge,
            ),
          ),
        ],
      ),
    );
  }
}
