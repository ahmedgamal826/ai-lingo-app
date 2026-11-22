import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';

class ConversationHintCard extends StatelessWidget {
  const ConversationHintCard({super.key, required this.hint});

  final String hint;

  @override
  Widget build(BuildContext context) {
    if (hint.isEmpty) return const SizedBox.shrink();
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingMd,
        vertical: 12,
      ),
      decoration: BoxDecoration(
        color: AppColors.purpleLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 2),
            child: SvgPicture.asset(AppAssets.hint, width: 14, height: 18),
          ),
          const SizedBox(width: AppDimensions.spaceMd),
          Expanded(
            child: CustomText(
              hint,
              style: AppTextStyles.conversationHint,
              maxLines: 3,
            ),
          ),
        ],
      ),
    );
  }
}
