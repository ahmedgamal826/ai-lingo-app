import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/quiz_result_models.dart';

class QuizResultsScoreCard extends StatelessWidget {
  const QuizResultsScoreCard({super.key, required this.result});

  final QuizAttemptResult result;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.primaryLight,
      elevation: AppDimensions.elevationNone,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMd,
        vertical: AppDimensions.spaceXl,
      ),
      child: Column(
        children: [
          SvgPicture.asset(
            AppAssets.trophy,
            width: AppDimensions.iconLg,
            height: AppDimensions.iconLg,
            colorFilter: const ColorFilter.mode(
              AppColors.primary,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMd),
          CustomText(result.scoreLabel, style: AppTextStyles.quizResultsScore),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(
            result.encouragementMessage,
            style: AppTextStyles.quizResultsEncouragement,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDimensions.spaceMd),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.successLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
            ),
            child: CustomText(
              result.pointsRankLabel,
              style: AppTextStyles.quizResultsPointsRank,
            ),
          ),
        ],
      ),
    );
  }
}
