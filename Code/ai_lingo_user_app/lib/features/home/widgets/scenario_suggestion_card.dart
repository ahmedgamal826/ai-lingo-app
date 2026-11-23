import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_card.dart';
import '../core/widgets/custom_text.dart';
import '../models/home_models.dart';
import 'home_scale.dart';

class ScenarioSuggestionCard extends StatelessWidget {
  const ScenarioSuggestionCard({super.key, required this.scenario, this.onTap});

  final ScenarioSuggestion scenario;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final radius = homeScale(context, AppDimensions.radiusLg);
    final padding = homeScale(context, AppDimensions.cardPaddingSm);
    final iconSize = homeScale(context, AppDimensions.icon22);
    final gap = homeScale(context, 7);

    return CustomCard(
      onTap: onTap,
      elevation: AppDimensions.elevationNone,
      backgroundColor: AppColors.white,
      borderRadius: BorderRadius.circular(radius),
      padding: EdgeInsets.all(padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            scenario.iconAsset,
            width: iconSize,
            height: iconSize,
          ),
          SizedBox(height: gap),
          CustomText(
            scenario.title,
            style: AppTextStyles.scenarioTitle.copyWith(
              fontSize: homeScale(
                context,
                AppTextStyles.scenarioTitle.fontSize!,
              ),
            ),
            maxLines: 2,
          ),
          SizedBox(height: gap),
          CustomText(
            scenario.meta,
            style: AppTextStyles.meta.copyWith(
              fontSize: homeScale(context, AppTextStyles.meta.fontSize!),
            ),
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
