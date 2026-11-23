import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';
import '../models/leaderboard_models.dart';

class LeaderboardPeriodTabs extends StatelessWidget {
  const LeaderboardPeriodTabs({
    super.key,
    required this.period,
    required this.onChanged,
  });

  final LeaderboardPeriod period;
  final ValueChanged<LeaderboardPeriod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.segmentedHeight,
      padding: const EdgeInsets.all(AppDimensions.spaceXs),
      decoration: BoxDecoration(
        color: AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabChip(
              label: AppStrings.tabWeekly,
              selected: period == LeaderboardPeriod.weekly,
              onTap: () => onChanged(LeaderboardPeriod.weekly),
            ),
          ),
          const SizedBox(width: AppDimensions.spaceXs),
          Expanded(
            child: _TabChip(
              label: AppStrings.tabOverall,
              selected: period == LeaderboardPeriod.overall,
              onTap: () => onChanged(LeaderboardPeriod.overall),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.white : AppColors.indicatorInactive,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Center(
          child: CustomText(
            label,
            style: selected
                ? AppTextStyles.tabLabelActive
                : AppTextStyles.tabLabel,
          ),
        ),
      ),
    );
  }
}
