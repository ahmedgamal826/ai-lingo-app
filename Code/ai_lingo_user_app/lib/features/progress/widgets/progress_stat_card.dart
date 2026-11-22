import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../vocabulary/widgets_core/custom_card.dart';

class ProgressStatCard extends StatelessWidget {
  const ProgressStatCard({
    super.key,
    required this.iconAsset,
    required this.value,
    required this.label,
  });

  final String iconAsset;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      elevation: 0,
      padding: const EdgeInsets.fromLTRB(12, 11, 10, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppAssets.icon(iconAsset),
            width: 19,
            height: 19,
            colorFilter: const ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
          ),
          const SizedBox(height: 7),
          Text(
            value,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 19,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 9,
            ),
          ),
        ],
      ),
    );
  }
}
