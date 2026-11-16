import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/weekly_test_models.dart';

class WeeklyTestMessageCard extends StatelessWidget {
  const WeeklyTestMessageCard({super.key, required this.message});

  final WeeklyTestMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(message.iconAsset, width: 20, height: 20),
          const SizedBox(width: AppDimensions.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  message.title,
                  style: AppTextStyles.weeklyTestMessageTitle,
                  maxLines: 2,
                ),
                const SizedBox(height: 5),
                CustomText(
                  message.body,
                  style: AppTextStyles.weeklyTestMessageBody,
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
