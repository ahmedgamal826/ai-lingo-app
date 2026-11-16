import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_button.dart';
import '../../../core/widgets/custom_card.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/conversation_models.dart';
import '../models/scenario_models.dart';
import '../viewmodels/conversation_evaluation_cubit.dart';
import '../viewmodels/conversation_evaluation_state.dart';
import '../widgets/evaluation_category_scores_row.dart';
import '../widgets/evaluation_correction_card.dart';
import '../widgets/evaluation_overall_score_card.dart';
import 'ai_conversation_view.dart';

/// Conversation Evaluation screen (Figma node 6:77869).
class ConversationEvaluationView extends StatelessWidget {
  const ConversationEvaluationView({
    super.key,
    required this.evaluation,
    required this.scenario,
    required this.levelLabel,
  });

  final ConversationEvaluation evaluation;
  final ScenarioItem scenario;
  final String levelLabel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ConversationEvaluationCubit(evaluation),
      child: _ConversationEvaluationBody(
        scenario: scenario,
        levelLabel: levelLabel,
      ),
    );
  }
}

class _ConversationEvaluationBody extends StatelessWidget {
  const _ConversationEvaluationBody({
    required this.scenario,
    required this.levelLabel,
  });

  final ScenarioItem scenario;
  final String levelLabel;

  void _tryAgain(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) =>
            AiConversationView(scenario: scenario, levelLabel: levelLabel),
      ),
    );
  }

  void _continueLearning(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  void _next(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<
      ConversationEvaluationCubit,
      ConversationEvaluationState
    >(
      builder: (context, state) {
        final evaluation = state.evaluation;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: AppStrings.evaluationTitle,
            subtitle: evaluation.evaluationSubtitle,
            centerTitle: false,
            backgroundColor: AppColors.white,
            titleStyle: AppTextStyles.pageTitle,
            subtitleStyle: AppTextStyles.pageSubtitle,
            height: AppDimensions.appBarHeightLg,
            leadingWidth: 56,
            titleSpacing: AppDimensions.spaceMd,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Material(
                color: Colors.transparent,
                shape: const CircleBorder(),
                child: InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => _continueLearning(context),
                  splashColor: AppColors.primary.withValues(alpha: 0.16),
                  highlightColor: AppColors.primaryLight.withValues(alpha: 0.7),
                  child: SizedBox(
                    width: 48,
                    height: 48,
                    child: Center(
                      child: SvgPicture.asset(
                        AppAssets.arrowLeft,
                        width: AppDimensions.navIconSize,
                        height: AppDimensions.navIconSize,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => _next(context),
                child: CustomText(
                  AppStrings.evaluationNext,
                  style: AppTextStyles.link.copyWith(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.screenPadding,
                      AppDimensions.spaceLg,
                      AppDimensions.screenPadding,
                      AppDimensions.spaceMd,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        EvaluationOverallScoreCard(evaluation: evaluation),
                        const SizedBox(height: AppDimensions.spaceMd),
                        EvaluationCategoryScoresRow(
                          scores: evaluation.categoryScores,
                        ),
                        const SizedBox(height: AppDimensions.spaceXl),
                        CustomText(
                          AppStrings.evaluationFixTitle,
                          style: AppTextStyles.sectionTitle,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        for (final correction in evaluation.corrections) ...[
                          EvaluationCorrectionCard(correction: correction),
                          const SizedBox(height: AppDimensions.spaceMd),
                        ],
                        const SizedBox(height: AppDimensions.spaceSm),
                        CustomText(
                          AppStrings.evaluationCoachTitle,
                          style: AppTextStyles.sectionTitle,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        CustomCard(
                          backgroundColor: AppColors.white,
                          elevation: AppDimensions.elevationSm,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusLg,
                          ),
                          padding: const EdgeInsets.all(
                            AppDimensions.paddingMd,
                          ),
                          child: CustomText(
                            evaluation.coachFeedback,
                            style: AppTextStyles.evaluationCoachBody.copyWith(
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 10,
                          ),
                        ),
                        const SizedBox(height: AppDimensions.spaceXl),
                        CustomText(
                          AppStrings.evaluationTryNextTitle,
                          style: AppTextStyles.sectionTitle,
                        ),
                        const SizedBox(height: AppDimensions.spaceMd),
                        for (final phrase in evaluation.suggestedPhrases) ...[
                          CustomText(
                            '"$phrase"',
                            style: AppTextStyles.evaluationSuggestion,
                            maxLines: 3,
                          ),
                          const SizedBox(height: AppDimensions.spaceMd),
                        ],
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppDimensions.screenPadding,
                    AppDimensions.spaceSm,
                    AppDimensions.screenPadding,
                    AppDimensions.spaceLg,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: CustomButton(
                          title: AppStrings.evaluationTryAgain,
                          height: 50,
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: AppColors.primary,
                          onPressed: () => _tryAgain(context),
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spaceMd),
                      Expanded(
                        flex: 12,
                        child: CustomButton(
                          title: AppStrings.evaluationContinueLearning,
                          height: 50,
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          onPressed: () => _continueLearning(context),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
