import 'package:ai_lingo_admin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_loading.dart';
import 'custom_text.dart';

/// Shared body of the three buttons below.
class _ButtonBody extends StatelessWidget {
  const _ButtonBody({
    required this.text,
    required this.background,
    required this.foreground,
    this.onTap,
    this.width,
    this.icon,
    this.isLoading = false,
  });

  final String text;
  final Color background;
  final Color foreground;
  final VoidCallback? onTap;
  final double? width;

  /// Optional icon shown before the text (e.g. the arrow of "Next").
  final IconData? icon;

  /// Shows a spinner instead of the text and ignores taps.
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final disabled = onTap == null;

    return GestureDetector(
      onTap: (disabled || isLoading) ? null : onTap,
      child: Opacity(
        opacity: disabled ? 0.5 : 1,
        child: Container(
          height: 50.h,
          width: width ?? double.infinity, // was `170 ?? 350`
          decoration: BoxDecoration(
            color: background,
            borderRadius: BorderRadius.circular(14), // was 8
          ),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 18,
                    height: 18,
                    child: CustomLoading(size: 18, color: foreground),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, size: 16, color: foreground),
                        const SizedBox(width: 6),
                      ],
                      CustomText(
                        text: text,
                        color: foreground,
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CustomDarkButton extends StatelessWidget {
  const CustomDarkButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.icon,
    this.isLoading = false,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _ButtonBody(
      text: text,
      onTap: onTap,
      width: width,
      icon: icon,
      isLoading: isLoading,
      background: AppColors.primary,
      foreground: AppColors.white,
    );
  }
}

class CustomLightButton extends StatelessWidget {
  const CustomLightButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.icon,
    this.isLoading = false,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _ButtonBody(
      text: text,
      onTap: onTap,
      width: width,
      icon: icon,
      isLoading: isLoading,
      background: AppColors.primaryLight,
      foreground: AppColors.primary,
    );
  }
}

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.icon,
    this.isLoading = false,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final IconData? icon;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return _ButtonBody(
      text: text,
      onTap: onTap,
      width: width,
      icon: icon,
      isLoading: isLoading,
      background: AppColors.errorLight,
      foreground: AppColors.danger,
    );
  }
}
