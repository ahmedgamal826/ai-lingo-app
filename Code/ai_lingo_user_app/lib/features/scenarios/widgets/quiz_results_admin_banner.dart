import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/quiz_result_models.dart';

class QuizResultsAdminBanner extends StatelessWidget {
  const QuizResultsAdminBanner({super.key, required this.adjustment});

  final AdminScoreAdjustment adjustment;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppAssets.circleCheck,
            width: AppDimensions.icon22,
            height: AppDimensions.icon22,
            colorFilter: const ColorFilter.mode(
              AppColors.success,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: AppDimensions.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  adjustment.messageTitle,
                  style: AppTextStyles.quizResultsAdminTitle,
                ),
                const SizedBox(height: AppDimensions.spaceXs),
                CustomText(
                  adjustment.messageBody,
                  style: AppTextStyles.quizResultsAdminBody,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
