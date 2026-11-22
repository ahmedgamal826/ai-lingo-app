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
import '../../home/views/main_shell_view.dart';
import '../../leaderboard/views/leaderboard_view.dart';
import '../models/quiz_result_models.dart';
import '../viewmodels/weekly_quiz_results_cubit.dart';
import '../viewmodels/weekly_quiz_results_state.dart';
import '../widgets/quiz_results_admin_banner.dart';
import '../widgets/quiz_results_category_card.dart';
import '../widgets/quiz_results_score_card.dart';
import '../widgets/quiz_results_stats_row.dart';

/// Weekly Quiz Results screen (Figma node 6:77761).
class WeeklyQuizResultsView extends StatelessWidget {
  const WeeklyQuizResultsView({
    super.key,
    required this.result,
    this.onContinueLearning,
  });

  final QuizAttemptResult result;
  final VoidCallback? onContinueLearning;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeeklyQuizResultsCubit(result),
      child: _WeeklyQuizResultsBody(onContinueLearning: onContinueLearning),
    );
  }
}

class _WeeklyQuizResultsBody extends StatelessWidget {
  const _WeeklyQuizResultsBody({this.onContinueLearning});

  final VoidCallback? onContinueLearning;

  Future<void> _openLeaderboard(BuildContext context) async {
    final tab = await Navigator.of(context).push<int>(
      MaterialPageRoute<int>(builder: (_) => const LeaderboardView()),
    );
    if (!context.mounted || tab == null) return;
    final shell = MainShellController.maybeOf(context);
    Navigator.of(context).maybePop();
    shell?.selectTab(tab);
  }

  void _continueLearning(BuildContext context) {
    Navigator.of(context).maybePop();
    onContinueLearning?.call();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeeklyQuizResultsCubit, WeeklyQuizResultsState>(
      builder: (context, state) {
        final result = state.result;
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: AppStrings.quizResultsTitle,
            subtitle: result.appBarSubtitle,
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
                  onTap: () => Navigator.of(context).maybePop(),
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
          ),
          body: SafeArea(
            top: false,
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(
                      AppDimensions.screenPadding,
                      AppDimensions.screenPadding,
                      AppDimensions.screenPadding,
                      AppDimensions.spaceMd,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        QuizResultsScoreCard(result: result),
                        const SizedBox(height: AppDimensions.spaceXl),
                        QuizResultsStatsRow(result: result),
                        const SizedBox(height: AppDimensions.spaceXl),
                        QuizResultsCategoryCard(categories: result.categories),
                        if (state.hasAdminAdjustment &&
                            result.adminAdjustment != null) ...[
                          const SizedBox(height: AppDimensions.spaceLg),
                          QuizResultsAdminBanner(
                            adjustment: result.adminAdjustment!,
                          ),
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
                  child: Column(
                    children: [
                      CustomButton(
                        title: AppStrings.quizResultsViewLeaderboard,
                        height: 50,
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        leading: SvgPicture.asset(
                          AppAssets.trophy,
                          width: AppDimensions.iconSm,
                          height: AppDimensions.iconSm,
                          colorFilter: const ColorFilter.mode(
                            AppColors.white,
                            BlendMode.srcIn,
                          ),
                        ),
                        onPressed: () => _openLeaderboard(context),
                      ),
                      const SizedBox(height: AppDimensions.spaceMd),
                      CustomButton(
                        title: AppStrings.quizResultsContinueLearning,
                        height: 50,
                        backgroundColor: AppColors.primaryLight,
                        foregroundColor: AppColors.primary,
                        onPressed: () => _continueLearning(context),
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
