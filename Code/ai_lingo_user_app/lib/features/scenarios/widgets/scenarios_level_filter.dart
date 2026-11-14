import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';

class ScenariosLevelFilter extends StatelessWidget {
  const ScenariosLevelFilter({super.key, required this.levelBadge});

  final String levelBadge;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            AppStrings.pickNextConversation,
            style: AppTextStyles.levelFilterLabel,
            maxLines: 1,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          ),
          child: CustomText(levelBadge, style: AppTextStyles.quizBadge),
        ),
      ],
    );
  }
}
