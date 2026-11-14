import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';

class LeaderboardTableHeader extends StatelessWidget {
  const LeaderboardTableHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              AppStrings.rankLearnerHeader,
              style: AppTextStyles.meta,
            ),
          ),
          CustomText(AppStrings.quizPointsHeader, style: AppTextStyles.meta),
        ],
      ),
    );
  }
}
