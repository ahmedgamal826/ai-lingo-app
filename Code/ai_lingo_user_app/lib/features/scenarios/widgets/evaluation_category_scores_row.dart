import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_card.dart';
import '../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';

class EvaluationCategoryScoresRow extends StatelessWidget {
  const EvaluationCategoryScoresRow({super.key, required this.scores});

  final List<CategoryScore> scores;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < scores.length; i++) ...[
          if (i > 0) const SizedBox(width: 10),
          Expanded(child: _CategoryScoreCard(score: scores[i])),
        ],
      ],
    );
  }
}

class _CategoryScoreCard extends StatelessWidget {
  const _CategoryScoreCard({required this.score});

  final CategoryScore score;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      elevation: 1,
      borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      child: Column(
        children: [
          CustomText(
            '${score.score}',
            style: AppTextStyles.evaluationCategoryScore,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 2),
          CustomText(
            score.label,
            style: AppTextStyles.evaluationCategoryLabel,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
