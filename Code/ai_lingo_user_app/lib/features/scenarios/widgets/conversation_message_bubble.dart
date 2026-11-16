import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';

class ConversationMessageBubble extends StatelessWidget {
  const ConversationMessageBubble({super.key, required this.message});

  final ConversationMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;
    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.82,
        ),
        child: Column(
          crossAxisAlignment: isUser
              ? CrossAxisAlignment.end
              : CrossAxisAlignment.start,
          children: [
            if (!isUser)
              Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 6),
                child: CustomText(
                  AppStrings.conversationAiLabel,
                  style: AppTextStyles.conversationAiLabel,
                ),
              ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMd,
                vertical: 12,
              ),
              decoration: BoxDecoration(
                color: isUser ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                border: isUser
                    ? null
                    : Border.all(color: AppColors.indicatorInactive),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (isUser) ...[
                    CustomText(
                      AppStrings.conversationYouLabel,
                      style: AppTextStyles.conversationYouLabel,
                    ),
                    const SizedBox(height: 4),
                  ],
                  CustomText(
                    message.text,
                    style: isUser
                        ? AppTextStyles.conversationUserBody
                        : AppTextStyles.conversationAiBody,
                    maxLines: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
