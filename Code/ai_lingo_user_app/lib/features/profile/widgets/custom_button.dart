import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/core/theme/app_dimensions.dart';
import 'package:ai_lingo_user_app/core/theme/app_font_sizes.dart';
import 'custom_text.dart';
import 'package:flutter/material.dart';

class CustomDarkButton extends StatelessWidget {
  const CustomDarkButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.leading,
    this.height = AppDimensions.buttonHeight,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final Widget? leading;
  final double height;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        child: Center(
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            if (leading != null) ...[leading!, const SizedBox(width: AppDimensions.spaceSm)],
            CustomText(text: text, color: AppColors.white, fontSize: AppFontSizes.font14),
          ]),
        ),
      ),
    );
  }
}

class CustomLightButton extends StatelessWidget {
  const CustomLightButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.buttonHeight,
        width: width ?? 350,

        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: AppColors.primary,
            fontSize: AppFontSizes.font14,
          ),
        ),
      ),
    );
  }
}

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppDimensions.buttonHeight,
        width: width ?? 350,
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: AppColors.danger,
            fontSize: AppFontSizes.font14,
          ),
        ),
      ),
    );
  }
}
