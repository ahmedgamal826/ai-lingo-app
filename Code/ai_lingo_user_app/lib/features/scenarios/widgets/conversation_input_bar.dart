import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text_field.dart';

class ConversationInputBar extends StatelessWidget {
  const ConversationInputBar({
    super.key,
    required this.controller,
    required this.enabled,
    required this.isBusy,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool enabled;
  final bool isBusy;
  final ValueChanged<String> onSend;

  static const double _fieldHeight = 48;
  static const double _sendSize = 48;
  static const InputBorder _noBorder = InputBorder.none;

  void _submit() {
    if (!enabled || isBusy) return;
    onSend(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    final canSend = enabled && !isBusy;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Container(
            height: _fieldHeight,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
              border: Border.all(color: AppColors.indicatorInactive, width: 1),
            ),
            child: Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    controller: controller,
                    enabled: canSend,
                    hintText: AppStrings.conversationInputHint,
                    textInputAction: TextInputAction.send,
                    onFieldSubmitted: (_) => _submit(),
                    isDense: true,
                    filled: true,
                    fillColor: Colors.transparent,
                    style: AppTextStyles.conversationAiBody,
                    hintStyle: AppTextStyles.conversationAiBody.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: AppDimensions.paddingMd,
                      vertical: 12,
                    ),
                    border: _noBorder,
                    enabledBorder: _noBorder,
                    focusedBorder: _noBorder,
                    disabledBorder: _noBorder,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 14),
                  child: SvgPicture.asset(
                    AppAssets.mic,
                    width: 20,
                    height: 20,
                    colorFilter: const ColorFilter.mode(
                      AppColors.textSecondary,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppDimensions.spaceMd),
        SizedBox(
          width: _sendSize,
          height: _sendSize,
          child: Material(
            color: canSend
                ? AppColors.primary
                : AppColors.primary.withValues(alpha: 0.45),
            shape: const CircleBorder(),
            clipBehavior: Clip.antiAlias,
            child: InkWell(
              customBorder: const CircleBorder(),
              onTap: canSend ? _submit : null,
              child: Center(
                child: isBusy
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: AppColors.white,
                        ),
                      )
                    : SvgPicture.asset(
                        AppAssets.send,
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
