import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_card.dart';
import '../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';

class EvaluationOverallScoreCard extends StatelessWidget {
  const EvaluationOverallScoreCard({super.key, required this.evaluation});

  final ConversationEvaluation evaluation;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.primaryLight,
      elevation: AppDimensions.elevationNone,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            '${evaluation.overallScore}',
            style: AppTextStyles.evaluationOverallScore,
          ),
          const SizedBox(height: 2),
          CustomText(
            AppStrings.evaluationOverallLabel,
            style: AppTextStyles.evaluationOverallCaption,
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(
            evaluation.overallSummary,
            style: AppTextStyles.evaluationSummary,
            maxLines: 3,
          ),
        ],
      ),
    );
  }
}
