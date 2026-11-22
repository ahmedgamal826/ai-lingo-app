import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';

class ConversationStatusRow extends StatelessWidget {
  const ConversationStatusRow({
    super.key,
    required this.availability,
    required this.canEvaluate,
    required this.isEvaluating,
    required this.onEndAndEvaluate,
  });

  final PartnerAvailability availability;
  final bool canEvaluate;
  final bool isEvaluating;
  final VoidCallback onEndAndEvaluate;

  @override
  Widget build(BuildContext context) {
    final isOnline = availability == PartnerAvailability.online;
    final label = switch (availability) {
      PartnerAvailability.online => AppStrings.conversationPartnerOnline,
      PartnerAvailability.demo => AppStrings.conversationPartnerDemo,
      PartnerAvailability.offline => AppStrings.conversationPartnerOffline,
    };
    final badgeColor = isOnline
        ? AppColors.successLight
        : AppColors.primaryLight;
    final textColor = isOnline ? AppColors.success : AppColors.primary;
    final dotColor = isOnline ? AppColors.success : AppColors.textSecondary;

    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: badgeColor,
            borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: dotColor,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 6),
              CustomText(
                label,
                style: AppTextStyles.conversationStatus.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        TextButton(
          onPressed: canEvaluate && !isEvaluating ? onEndAndEvaluate : null,
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primary,
            disabledForegroundColor: AppColors.textSecondary,
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          child: isEvaluating
              ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : CustomText(
                  AppStrings.conversationEndEvaluate,
                  style: AppTextStyles.conversationEndAction.copyWith(
                    color: canEvaluate
                        ? AppColors.primary
                        : AppColors.textSecondary,
                  ),
                ),
        ),
      ],
    );
  }
}
