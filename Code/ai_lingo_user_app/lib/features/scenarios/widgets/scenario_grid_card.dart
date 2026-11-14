import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/scenario_models.dart';

class ScenarioGridCard extends StatelessWidget {
  const ScenarioGridCard({super.key, required this.item, this.onTap});

  final ScenarioItem item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      onTap: onTap,
      elevation: AppDimensions.elevationNone,
      backgroundColor: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimensions.scenarioCardRadius),
      padding: const EdgeInsets.all(AppDimensions.scenarioCardPadding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppDimensions.scenarioIconTile,
            height: AppDimensions.scenarioIconTile,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: SvgPicture.asset(
              item.iconAsset,
              width: AppDimensions.icon22,
              height: AppDimensions.icon22,
            ),
          ),
          const SizedBox(height: 9),
          CustomText(
            item.title,
            style: AppTextStyles.scenarioCardTitle,
            maxLines: 2,
          ),
          const SizedBox(height: 9),
          CustomText(item.description, style: AppTextStyles.meta, maxLines: 2),
          const SizedBox(height: 9),
          CustomText(
            item.meta,
            style: AppTextStyles.scenarioCardMeta,
            maxLines: 1,
          ),
        ],
      ),
    );
  }
}
