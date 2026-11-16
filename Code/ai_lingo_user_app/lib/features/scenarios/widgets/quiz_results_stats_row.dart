import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/quiz_result_models.dart';

class QuizResultsStatsRow extends StatelessWidget {
  const QuizResultsStatsRow({super.key, required this.result});

  final QuizAttemptResult result;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _StatItem(
            value: result.correctAnswersLabel,
            label: AppStrings.quizResultsCorrectAnswers,
          ),
        ),
        Expanded(
          child: _StatItem(
            value: result.timeTakenLabel,
            label: AppStrings.quizResultsTimeTaken,
          ),
        ),
        Expanded(
          child: _StatItem(
            value: result.attemptUsedLabel,
            label: AppStrings.quizResultsAttemptUsed,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          value,
          style: AppTextStyles.quizResultsStatValue,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: AppDimensions.spaceXs),
        CustomText(
          label,
          style: AppTextStyles.quizResultsStatLabel,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
