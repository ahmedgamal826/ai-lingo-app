import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'app_font_sizes.dart';

/// Typography styles sourced from Figma (Inter).
class AppTextStyles {
  AppTextStyles._();

  static const String fontFamily = 'Inter';
  static const double _lineHeight = 1.4;

  static TextStyle get pageTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font22,
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

  static TextStyle get filterMeta => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get complaintName => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get complaintMeta => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font9,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get complaintTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get complaintBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get avatarInitials => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get statusPending => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.warning,
  );

  static TextStyle get statusInProgress => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get statusResolved => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  static TextStyle get loadMore => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get loadMoreAction => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.primary,
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

  static TextStyle get placeholderTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font22,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsHeaderTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font16,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsLearnerName => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsLearnerEmail => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get detailsComplaintTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font18,
    fontWeight: FontWeight.w700,
    height: 1.3,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsMeta => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get detailsMessage => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsLink => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.primary,
  );

  static TextStyle get detailsSectionTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsInput => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.textPrimary,
  );

  static TextStyle get detailsHelper => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get detailsButton => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle get replySuccessHeading => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font24,
    fontWeight: FontWeight.w700,
    height: 1.25,
    color: AppColors.textPrimary,
  );

  static TextStyle get replySuccessBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w400,
    height: 1.45,
    color: AppColors.textSecondary,
  );

  static TextStyle get replySuccessCardTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get replySuccessCardBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w400,
    height: 1.4,
    color: AppColors.textSecondary,
  );
}
