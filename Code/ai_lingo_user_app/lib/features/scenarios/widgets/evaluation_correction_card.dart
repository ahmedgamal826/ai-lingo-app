import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';

class EvaluationCorrectionCard extends StatelessWidget {
  const EvaluationCorrectionCard({super.key, required this.correction});

  final GrammarCorrection correction;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: AppColors.warningLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
            ),
            child: CustomText(
              correction.badgeLabel,
              style: AppTextStyles.evaluationCorrectionBadge,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceMd),
          CustomText(
            'You said: "${correction.originalText}"',
            style: AppTextStyles.evaluationSaid,
            maxLines: 5,
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(
            'Try: "${correction.correctedText}"',
            style: AppTextStyles.evaluationTry,
            maxLines: 5,
          ),
          const SizedBox(height: AppDimensions.spaceSm),
          CustomText(
            correction.explanation,
            style: AppTextStyles.evaluationExplanation,
            maxLines: 5,
          ),
        ],
      ),
    );
  }
}
