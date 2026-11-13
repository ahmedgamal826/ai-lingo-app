import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

/// Color tone shared by badges and info cards.
enum CustomTone { neutral, info, success, warning, danger, purple }

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.elevation,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final BorderRadius? borderRadius;
  final BoxBorder? border;
  final double? elevation;
  final VoidCallback? onTap;

  // ---------- Stat card: number + title (+ icon, + small caption) ----------
  factory CustomCard.stat({
    Key? key,
    required String title,
    required String value,
    IconData? icon,
    String? caption,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      key: key,
      onTap: onTap,
      backgroundColor: AppColors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppDimensions.iconMd, color: AppColors.primary),
            const SizedBox(height: AppDimensions.spaceSm),
          ],
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(
            title,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
          if (caption != null) ...[
            const SizedBox(height: AppDimensions.spaceXs),
            Text(
              caption,
              style: const TextStyle(fontSize: 11, color: AppColors.success),
            ),
          ],
        ],
      ),
    );
  }

  // ---------- Info banner: colored box with icon + message ----------
  factory CustomCard.info({
    Key? key,
    required String message,
    String? title,
    CustomTone tone = CustomTone.info,
    IconData? icon,
  }) {
    final colors = _ToneColors.of(tone);
    return CustomCard(
      key: key,
      backgroundColor: colors.background,
      elevation: AppDimensions.elevationNone,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: AppDimensions.iconMd, color: colors.foreground),
            const SizedBox(width: AppDimensions.spaceMd),
          ],
          Expanded(
            child: _TitleSubtitle(
              title: title ?? message,
              subtitle: title == null ? null : message,
            ),
          ),
        ],
      ),
    );
  }

  // ---------- Selectable card: highlighted border + check when selected ----------
  factory CustomCard.selectable({
    Key? key,
    required String title,
    required bool selected,
    String? subtitle,
    Widget? leading,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      key: key,
      onTap: onTap,
      backgroundColor: selected ? AppColors.primaryLight : AppColors.white,
      border: Border.all(
        color: selected ? AppColors.primary : AppColors.indicatorInactive,
      ),
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: AppDimensions.spaceMd),
          ],
          Expanded(child: _TitleSubtitle(title: title, subtitle: subtitle)),
          if (selected)
            const Icon(
              Icons.check_circle_outline,
              size: AppDimensions.iconMd,
              color: AppColors.primary,
            ),
        ],
      ),
    );
  }

  // ---------- List item: leading + title/subtitle + trailing ----------
  // Covers notifications, complaints, profile/settings rows, learner results...
  factory CustomCard.listItem({
    Key? key,
    required String title,
    String? subtitle,
    Widget? leading,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      key: key,
      onTap: onTap,
      backgroundColor: AppColors.white,
      child: Row(
        children: [
          if (leading != null) ...[
            leading,
            const SizedBox(width: AppDimensions.spaceMd),
          ],
          Expanded(child: _TitleSubtitle(title: title, subtitle: subtitle)),
          if (trailing != null) ...[
            const SizedBox(width: AppDimensions.spaceMd),
            trailing,
          ],
        ],
      ),
    );
  }

  // ---------- Hero card: big tinted card, content is up to the screen ----------
  factory CustomCard.hero({
    Key? key,
    required Widget child,
    VoidCallback? onTap,
  }) {
    return CustomCard(
      key: key,
      onTap: onTap,
      backgroundColor: AppColors.primaryLight,
      elevation: AppDimensions.elevationNone,
      borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
      padding: const EdgeInsets.all(AppDimensions.paddingLg),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final radius =
        borderRadius ?? BorderRadius.circular(AppDimensions.radiusMd);

    return Material(
      color: backgroundColor,
      elevation: elevation ?? AppDimensions.elevationSm,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Container(
          padding: padding ?? const EdgeInsets.all(AppDimensions.paddingMd),
          decoration: BoxDecoration(borderRadius: radius, border: border),
          child: child,
        ),
      ),
    );
  }
}

/// Small pill: Pending / Resolved / Closed / "B1 · Intermediate" ...
class CustomStatusBadge extends StatelessWidget {
  const CustomStatusBadge({
    super.key,
    required this.label,
    this.tone = CustomTone.neutral,
  });

  final String label;
  final CustomTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = _ToneColors.of(tone);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(AppDimensions.radiusFull),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w600,
          color: colors.foreground,
        ),
      ),
    );
  }
}

// ---------- private helpers (only used inside this file) ----------

class _ToneColors {
  const _ToneColors(this.background, this.foreground);

  final Color background;
  final Color foreground;

  static _ToneColors of(CustomTone tone) {
    switch (tone) {
      case CustomTone.info:
        return const _ToneColors(AppColors.primaryLight, AppColors.primary);
      case CustomTone.success:
        return const _ToneColors(AppColors.successLight, AppColors.success);
      case CustomTone.warning:
        return const _ToneColors(AppColors.warningLight, AppColors.warning);
      case CustomTone.danger:
        return const _ToneColors(AppColors.errorLight, AppColors.danger);
      case CustomTone.purple:
        return const _ToneColors(AppColors.purpleLight, AppColors.purple);
      case CustomTone.neutral:
        return const _ToneColors(
          AppColors.indicatorInactive,
          AppColors.textSecondary,
        );
    }
  }
}

class _TitleSubtitle extends StatelessWidget {
  const _TitleSubtitle({required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: AppDimensions.spaceXs),
          Text(
            subtitle!,
            style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
          ),
        ],
      ],
    );
  }
}