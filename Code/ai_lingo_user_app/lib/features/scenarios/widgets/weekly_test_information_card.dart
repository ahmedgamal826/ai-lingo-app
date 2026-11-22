import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';
import '../models/weekly_test_models.dart';

class WeeklyTestInformationCard extends StatelessWidget {
  const WeeklyTestInformationCard({super.key, required this.rows});

  final List<WeeklyTestInfoRow> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppDimensions.paddingMd),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppDimensions.radiusXxl),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08263166),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Column(children: [for (final row in rows) _InfoRow(row: row)]),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.row});

  final WeeklyTestInfoRow row;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceXs),
      child: Row(
        children: [
          Container(
            width: AppDimensions.scenarioIconTile,
            height: AppDimensions.scenarioIconTile,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            ),
            child: SvgPicture.asset(row.iconAsset, width: 20, height: 20),
          ),
          const SizedBox(width: AppDimensions.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  row.title,
                  style: AppTextStyles.weeklyTestInfoTitle,
                  maxLines: 2,
                ),
                if (row.subtitle != null) ...[
                  const SizedBox(height: AppDimensions.spaceXs),
                  CustomText(
                    row.subtitle!,
                    style: AppTextStyles.weeklyTestInfoSubtitle,
                    maxLines: 2,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
