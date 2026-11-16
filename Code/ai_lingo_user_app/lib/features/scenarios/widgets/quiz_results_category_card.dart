import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/quiz_result_models.dart';

class QuizResultsCategoryCard extends StatelessWidget {
  const QuizResultsCategoryCard({super.key, required this.categories});

  final List<CategoryPerformance> categories;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      elevation: AppDimensions.elevationSm,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      child: Column(
        children: [
          for (var i = 0; i < categories.length; i++) ...[
            if (i > 0) const SizedBox(height: AppDimensions.spaceLg),
            _CategoryRow(item: categories[i]),
          ],
        ],
      ),
    );
  }
}

class _CategoryRow extends StatelessWidget {
  const _CategoryRow({required this.item});

  final CategoryPerformance item;

  @override
  Widget build(BuildContext context) {
    final badgeStyle = item.isPerfect
        ? AppTextStyles.quizResultsCategoryBadgePerfect
        : AppTextStyles.quizResultsCategoryBadge;
    final badgeColor = item.isPerfect
        ? AppColors.successLight
        : AppColors.primaryLight;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                item.category,
                style: AppTextStyles.quizResultsCategoryTitle,
              ),
              if (item.feedback != null && item.feedback!.isNotEmpty) ...[
                const SizedBox(height: AppDimensions.spaceXs),
                CustomText(
                  item.feedback!,
                  style: AppTextStyles.quizResultsCategoryFeedback,
                ),
              ],
            ],
          ),
        ),
        const SizedBox(width: AppDimensions.spaceMd),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          child: CustomText(item.scoreLabel, style: badgeStyle),
        ),
      ],
    );
  }
}
