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

  static TextStyle get weeklyTestTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font20,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get weeklyTestCountdownLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.primary,
  );

  static TextStyle get weeklyTestCountdownValue => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font24,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get weeklyTestInfoTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get weeklyTestInfoSubtitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get weeklyTestMessageTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get weeklyTestMessageBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get weeklyTestDisabledButton => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static TextStyle get quizQuestionCounter => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get quizTimerLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get quizCategoryBadge => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get quizPrompt => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font18,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get quizOptionKey => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w700,
  );

  static TextStyle get quizOptionText => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w500,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get quizAutoSave => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get quizResultsScore => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font36,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.primary,
  );

  static TextStyle get quizResultsEncouragement => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font16,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get quizResultsPointsRank => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.success,
  );

  static TextStyle get quizResultsStatValue => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font18,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get quizResultsStatLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get quizResultsCategoryTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get quizResultsCategoryFeedback => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get quizResultsCategoryBadge => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get quizResultsCategoryBadgePerfect => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w600,
    color: AppColors.success,
  );

  static TextStyle get quizResultsAdminTitle => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w700,
    height: _lineHeight,
    color: AppColors.success,
  );

  static TextStyle get quizResultsAdminBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.success,
  );

  static TextStyle get conversationAiLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w700,
    color: AppColors.purple,
  );

  static TextStyle get conversationYouLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w700,
    color: AppColors.white,
  );

  static TextStyle get conversationAiBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get conversationUserBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.white,
  );

  static TextStyle get conversationHint => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w500,
    height: _lineHeight,
    color: AppColors.purple,
  );

  static TextStyle get conversationStatus => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get conversationEndAction => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w600,
  );

  static TextStyle get evaluationOverallScore => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font40,
    fontWeight: FontWeight.w700,
    height: 1.1,
    color: AppColors.primary,
  );

  static TextStyle get evaluationOverallCaption => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );

  static TextStyle get evaluationSummary => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font14,
    fontWeight: FontWeight.w500,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get evaluationCategoryScore => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font22,
    fontWeight: FontWeight.w700,
    color: AppColors.primary,
  );

  static TextStyle get evaluationCategoryLabel => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font11,
    fontWeight: FontWeight.w400,
    color: AppColors.textSecondary,
  );

  static TextStyle get evaluationCorrectionBadge => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font10,
    fontWeight: FontWeight.w600,
    color: AppColors.warning,
  );

  static TextStyle get evaluationSaid => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w500,
    height: _lineHeight,
    color: AppColors.danger,
  );

  static TextStyle get evaluationTry => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w500,
    height: _lineHeight,
    color: AppColors.success,
  );

  static TextStyle get evaluationExplanation => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font12,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textSecondary,
  );

  static TextStyle get evaluationCoachBody => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w400,
    height: _lineHeight,
    color: AppColors.textPrimary,
  );

  static TextStyle get evaluationSuggestion => const TextStyle(
    fontFamily: fontFamily,
    fontSize: AppFontSizes.font13,
    fontWeight: FontWeight.w600,
    height: _lineHeight,
    color: AppColors.primary,
  );
}
