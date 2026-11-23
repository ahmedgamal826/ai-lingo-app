import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimensions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.centerTitle = true,
    this.backgroundColor,
    this.titleStyle,
    this.subtitleStyle,
    this.height = AppDimensions.appBarHeight,
    this.foregroundColor,
    this.titleSpacing,
    this.leadingWidth,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final bool centerTitle;
  final Color? backgroundColor;
  final TextStyle? titleStyle;
  final TextStyle? subtitleStyle;
  final double height;
  final Color? foregroundColor;
  final double? titleSpacing;
  final double? leadingWidth;

  @override
  Size get preferredSize => Size.fromHeight(height);

  @override
  Widget build(BuildContext context) {
    final alignment = centerTitle
        ? CrossAxisAlignment.center
        : CrossAxisAlignment.start;

    final titleChild = subtitle == null
        ? Text(title, style: titleStyle)
        : Column(
            crossAxisAlignment: alignment,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: titleStyle),
              const SizedBox(height: 2),
              Text(subtitle!, style: subtitleStyle),
            ],
          );

    return AppBar(
      title: titleChild,
      titleSpacing:
          titleSpacing ??
          (leading == null
              ? AppDimensions.screenPadding
              : AppDimensions.spaceMd),
      leading: leading,
      leadingWidth: leadingWidth,
      automaticallyImplyLeading: leading != null,
      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: backgroundColor ?? AppColors.white,
      foregroundColor: foregroundColor ?? AppColors.textPrimary,
      surfaceTintColor: AppColors.white,
      scrolledUnderElevation: AppDimensions.elevationNone,
      elevation: AppDimensions.elevationNone,
      toolbarHeight: height,
    );
  }
}
