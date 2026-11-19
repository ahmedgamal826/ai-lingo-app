import 'package:ai_lingo_admin_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../theme/app_dimensions.dart';
import 'custom_text.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
  });

  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;

  @override
  Size get preferredSize => const Size.fromHeight(AppDimensions.appBarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: leading,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor,
      elevation: AppDimensions.elevationNone,
    );
  }
}

/// White app bar: back arrow + bold title (Sign up / Forgot password).
class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.onBack,
  });

  final String title;

  /// Small caps line under the title (e.g. "ACCOUNT CREATED · LAST STEP").
  final String? subtitle;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.white,
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: onBack ?? () => Navigator.maybePop(context),
                child: const Icon(
                  Icons.arrow_back,
                  size: 24,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: title,
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      maxLines: 1,
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      CustomText(
                        text: subtitle!,
                        fontSize: 9,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                        maxLines: 1,
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
