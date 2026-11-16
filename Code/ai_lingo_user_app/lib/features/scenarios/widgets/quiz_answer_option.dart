import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/quiz_models.dart';

class QuizAnswerOption extends StatelessWidget {
  const QuizAnswerOption({
    super.key,
    required this.option,
    required this.selected,
    required this.onTap,
  });

  final QuizOption option;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            border: Border.all(
              color: selected ? AppColors.primary : AppColors.indicatorInactive,
              width: selected ? 1.5 : 1,
            ),
          ),
          child: Row(
            children: [
              Container(
                width: 32,
                height: 32,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: selected
                      ? AppColors.primary
                      : AppColors.indicatorInactive,
                  shape: BoxShape.circle,
                ),
                child: CustomText(
                  option.key,
                  style: AppTextStyles.quizOptionKey.copyWith(
                    color: selected ? AppColors.white : AppColors.textPrimary,
                  ),
                ),
              ),
              const SizedBox(width: AppDimensions.spaceMd),
              Expanded(
                child: CustomText(
                  option.text,
                  style: AppTextStyles.quizOptionText,
                  maxLines: 3,
                ),
              ),
              if (selected) ...[
                const SizedBox(width: AppDimensions.spaceSm),
                SvgPicture.asset(AppAssets.circleCheck, width: 20, height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
