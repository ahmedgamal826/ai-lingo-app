import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/home_models.dart';
import 'home_scale.dart';

class SavedWordPreviewCard extends StatelessWidget {
  const SavedWordPreviewCard({
    super.key,
    required this.preview,
    this.onPlayTap,
  });

  final SavedWordPreview preview;
  final VoidCallback? onPlayTap;

  @override
  Widget build(BuildContext context) {
    final radius = homeScale(context, AppDimensions.radiusLg);
    final padding = homeScale(context, AppDimensions.cardPaddingSm);
    final bookmarkSize = homeScale(context, AppDimensions.icon22);
    final volumeSize = homeScale(context, AppDimensions.icon18);

    return CustomCard(
      elevation: AppDimensions.elevationNone,
      backgroundColor: AppColors.white,
      borderRadius: BorderRadius.circular(radius),
      padding: EdgeInsets.all(padding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            AppAssets.bookmark,
            width: bookmarkSize,
            height: bookmarkSize,
          ),
          SizedBox(width: homeScale(context, AppDimensions.spaceMd)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  preview.word,
                  style: AppTextStyles.wordTitle.copyWith(
                    fontSize: homeScale(
                      context,
                      AppTextStyles.wordTitle.fontSize!,
                    ),
                  ),
                  maxLines: 1,
                ),
                SizedBox(height: homeScale(context, 2)),
                CustomText(
                  preview.definition,
                  style: AppTextStyles.caption.copyWith(
                    fontSize: homeScale(
                      context,
                      AppTextStyles.caption.fontSize!,
                    ),
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
          SizedBox(width: homeScale(context, AppDimensions.spaceSm)),
          GestureDetector(
            onTap: onPlayTap,
            child: SvgPicture.asset(
              AppAssets.volume2,
              width: volumeSize,
              height: volumeSize,
            ),
          ),
        ],
      ),
    );
  }
}
