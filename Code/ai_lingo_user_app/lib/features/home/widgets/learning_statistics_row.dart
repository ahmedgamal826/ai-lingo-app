import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';
import '../models/home_models.dart';
import 'home_scale.dart';

class LearningStatisticsRow extends StatelessWidget {
  const LearningStatisticsRow({super.key, required this.stats});

  final List<LearningStat> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < stats.length; i++) ...[
          if (i > 0) SizedBox(width: homeScale(context, 10)),
          Expanded(child: _StatItem(stat: stats[i])),
        ],
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  const _StatItem({required this.stat});

  final LearningStat stat;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          stat.value,
          style: AppTextStyles.statisticValue.copyWith(
            fontSize: homeScale(
              context,
              AppTextStyles.statisticValue.fontSize!,
            ),
          ),
          textAlign: TextAlign.center,
        ),
        SizedBox(height: homeScale(context, 3)),
        CustomText(
          stat.label,
          style: AppTextStyles.meta.copyWith(
            fontSize: homeScale(context, AppTextStyles.meta.fontSize!),
          ),
          textAlign: TextAlign.center,
          maxLines: 1,
        ),
      ],
    );
  }
}
