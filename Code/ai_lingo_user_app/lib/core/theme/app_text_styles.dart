import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_sizes.dart';

/// Typography styles sourced from Figma (Inter).
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';
  static const double _lineHeight = 1.4;

  static TextStyle get greeting => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font20,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get avatarInitials => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font19,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get sectionTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get cardTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get buttonLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );

  static TextStyle get wordTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get bodySecondary => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get scenarioTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get progressPercent => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.primary,
  );

  static TextStyle get caption => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get captionBold => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get link => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get meta => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get streakBadge => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.warning,
  );

  static TextStyle get unreadBadge => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font9,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static TextStyle get statisticValue => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font20,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get appBarTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get navLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font9,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get navLabelActive => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font9,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get pageTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font18,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get pageSubtitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get tabLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get tabLabelActive => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get podiumCaption => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.primary,
  );

  static TextStyle get podiumName => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get rankingName => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get rankingMeta => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get rankingPoints => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get currentUserHint => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font9,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.primary,
  );

  static TextStyle get quizBadge => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get practiceAppBarTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get levelFilterLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get scenarioCardTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get scenarioCardMeta => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.primary,
  );
}
