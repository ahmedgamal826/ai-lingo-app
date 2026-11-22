import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_app_bar.dart';
import '../core/widgets/custom_button.dart';
import '../core/widgets/custom_dialog.dart';
import '../core/widgets/custom_text.dart';
import '../models/quiz_models.dart';
import '../viewmodels/weekly_quiz_cubit.dart';
import '../viewmodels/weekly_quiz_state.dart';
import '../widgets/quiz_answer_option.dart';

/// Weekly Quiz In Progress screen (Figma node 6:77712).
class WeeklyQuizView extends StatelessWidget {
  const WeeklyQuizView({super.key, this.config});

  final QuizSessionConfig? config;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeeklyQuizCubit(config: config),
      child: const _WeeklyQuizViewBody(),
    );
  }
}

class _WeeklyQuizViewBody extends StatelessWidget {
  const _WeeklyQuizViewBody();

  Future<void> _handleBack(BuildContext context) async {
    final shouldLeave = await CustomDialog.showConfirm(
      context,
      title: AppStrings.quizExitTitle,
      message: AppStrings.quizExitMessage,
      confirmLabel: AppStrings.quizLeave,
      cancelLabel: AppStrings.quizStay,
    );
    if (shouldLeave == true && context.mounted) {
      Navigator.of(context).maybePop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WeeklyQuizCubit, WeeklyQuizState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          (current.status == QuizSessionStatus.finished ||
              current.status == QuizSessionStatus.timedOut),
      listener: (context, state) {
        Navigator.of(context).pop(state.result);
      },
      builder: (context, state) {
        final question = state.currentQuestion;
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: state.config.title,
            subtitle: state.config.subtitle,
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
                  onTap: () => _handleBack(context),
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
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Material(
                  color: Colors.transparent,
                  shape: const CircleBorder(),
                  child: InkWell(
                    customBorder: const CircleBorder(),
                    onTap: context
                        .read<WeeklyQuizCubit>()
                        .toggleFlagCurrentQuestion,
                    splashColor: AppColors.primary.withValues(alpha: 0.16),
                    highlightColor: AppColors.primaryLight.withValues(
                      alpha: 0.7,
                    ),
                    child: SizedBox(
                      width: 48,
                      height: 48,
                      child: Center(
                        child: SvgPicture.asset(
                          AppAssets.flag,
                          width: AppDimensions.navIconSize,
                          height: AppDimensions.navIconSize,
                          colorFilter: ColorFilter.mode(
                            state.isFlagged(question.id)
                                ? AppColors.primary
                                : AppColors.primary,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.screenPadding,
                AppDimensions.screenPadding,
                AppDimensions.screenPadding,
                AppDimensions.spaceLg,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: CustomText(
                          state.questionCounterLabel,
                          style: AppTextStyles.quizQuestionCounter,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          borderRadius: BorderRadius.circular(
                            AppDimensions.radiusFull,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              AppAssets.timer,
                              width: 14,
                              height: 14,
                            ),
                            const SizedBox(width: 6),
                            CustomText(
                              state.remainingLabel,
                              style: AppTextStyles.quizTimerLabel,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(
                      AppDimensions.radiusFull,
                    ),
                    child: LinearProgressIndicator(
                      value: state.progress,
                      minHeight: 8,
                      backgroundColor: AppColors.indicatorInactive,
                      color: AppColors.primary,
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(
                          AppDimensions.radiusFull,
                        ),
                      ),
                      child: CustomText(
                        question.categoryBadgeLabel,
                        style: AppTextStyles.quizCategoryBadge,
                      ),
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  CustomText(
                    question.prompt,
                    style: AppTextStyles.quizPrompt,
                    maxLines: 5,
                  ),
                  const SizedBox(height: AppDimensions.spaceLg),
                  Expanded(
                    child: ListView(
                      children: [
                        for (final option in question.options) ...[
                          QuizAnswerOption(
                            option: option,
                            selected: state.currentSelectedKey == option.key,
                            onTap: () => context
                                .read<WeeklyQuizCubit>()
                                .selectAnswer(option.key),
                          ),
                          const SizedBox(height: AppDimensions.spaceMd),
                        ],
                        CustomText(
                          AppStrings.quizAnswersSaved,
                          style: AppTextStyles.quizAutoSave,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDimensions.spaceMd),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          title: AppStrings.quizPrevious,
                          isEnabled: !state.isFirstQuestion,
                          height: 50,
                          backgroundColor: AppColors.primaryLight,
                          foregroundColor: AppColors.primary,
                          onPressed: state.isFirstQuestion
                              ? null
                              : context
                                    .read<WeeklyQuizCubit>()
                                    .previousQuestion,
                        ),
                      ),
                      const SizedBox(width: AppDimensions.spaceMd),
                      Expanded(
                        child: CustomButton(
                          title: state.isLastQuestion
                              ? AppStrings.quizFinish
                              : AppStrings.quizNextQuestion,
                          height: 50,
                          backgroundColor: AppColors.primary,
                          foregroundColor: AppColors.white,
                          onPressed: context
                              .read<WeeklyQuizCubit>()
                              .nextQuestion,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
