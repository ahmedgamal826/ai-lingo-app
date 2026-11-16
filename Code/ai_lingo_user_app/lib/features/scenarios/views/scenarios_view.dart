import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../core/widgets/custom_segmented_tabs.dart';
import '../../../core/widgets/custom_text.dart';
import '../../home/views/main_shell_view.dart';
import '../models/quiz_result_models.dart';
import '../models/scenario_models.dart';
import '../models/weekly_test_models.dart';
import '../viewmodels/scenarios_cubit.dart';
import '../viewmodels/scenarios_state.dart';
import '../widgets/scenario_grid_card.dart';
import '../widgets/scenarios_level_filter.dart';
import '../widgets/weekly_test_panel.dart';
import 'ai_conversation_view.dart';
import 'weekly_quiz_results_view.dart';
import 'weekly_quiz_view.dart';

/// Practice Scenarios / Weekly Test screen — UI only.
class ScenariosView extends StatelessWidget {
  const ScenariosView({super.key, this.showBottomNav = true});

  /// When false, the root [MainShellView] owns the bottom navigation bar.
  final bool showBottomNav;

  static const List<SegmentedTabItem> _tabs = [
    SegmentedTabItem(id: 'scenarios', label: AppStrings.tabScenarios),
    SegmentedTabItem(id: 'weekly_test', label: AppStrings.tabWeeklyTest),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScenariosCubit(),
      child: _ScenariosViewBody(showBottomNav: showBottomNav),
    );
  }
}

class _ScenariosViewBody extends StatelessWidget {
  const _ScenariosViewBody({required this.showBottomNav});

  final bool showBottomNav;

  Future<void> _openQuiz(BuildContext context) async {
    final cubit = context.read<ScenariosCubit>();
    if (!cubit.beginWeeklyTestSession()) return;
    try {
      final result = await Navigator.of(context).push<QuizAttemptResult>(
        MaterialPageRoute<QuizAttemptResult>(
          builder: (_) => const WeeklyQuizView(),
        ),
      );
      if (result != null) {
        cubit.saveAttemptResult(result);
      }
    } finally {
      cubit.clearWeeklyTestStartLock();
    }
  }

  Future<void> _openResults(BuildContext context) async {
    final cubit = context.read<ScenariosCubit>();
    if (!cubit.beginWeeklyResultsSession()) return;
    try {
      final result = cubit.resolveAttemptResult();
      if (result == null || !context.mounted) return;
      await Navigator.of(context).push<void>(
        MaterialPageRoute<void>(
          builder: (_) => WeeklyQuizResultsView(
            result: result,
            onContinueLearning: () {
              cubit.selectTab(PracticeTab.scenarios);
            },
          ),
        ),
      );
    } finally {
      cubit.clearWeeklyResultsOpenLock();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScenariosCubit, ScenariosState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: AppStrings.practiceTitle,
            subtitle: AppStrings.practiceSubtitle,
            centerTitle: false,
            backgroundColor: AppColors.white,
            titleStyle: AppTextStyles.practiceAppBarTitle,
            subtitleStyle: AppTextStyles.pageSubtitle,
            height: AppDimensions.appBarHeightLg,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.screenPadding,
              AppDimensions.screenPadding,
              AppDimensions.screenPadding,
              AppDimensions.spaceXl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomSegmentedTabs(
                  items: ScenariosView._tabs,
                  selectedId: state.isScenariosTab
                      ? 'scenarios'
                      : 'weekly_test',
                  onChanged: (id) {
                    context.read<ScenariosCubit>().selectTab(
                      id == 'weekly_test'
                          ? PracticeTab.weeklyTest
                          : PracticeTab.scenarios,
                    );
                  },
                ),
                const SizedBox(height: AppDimensions.spaceMd),
                Expanded(
                  child: state.isScenariosTab
                      ? _ScenariosTabContent(state: state)
                      : WeeklyTestPanel(
                          info: state.weeklyTest,
                          status: state.weeklyTestStatus,
                          countdown: state.weeklyCountdownRemaining,
                          onPrimaryAction: () {
                            if (state.weeklyTestStatus ==
                                WeeklyTestStatus.closed) {
                              _openResults(context);
                              return;
                            }
                            _openQuiz(context);
                          },
                        ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: showBottomNav
              ? CustomBottomNavBar(
                  currentIndex: state.selectedNavIndex,
                  items: MainShellView.navItems,
                  onTap: (index) {
                    if (index == 0 && Navigator.of(context).canPop()) {
                      Navigator.of(context).pop();
                      return;
                    }
                    context.read<ScenariosCubit>().selectNav(index);
                  },
                )
              : null,
        );
      },
    );
  }
}

class _ScenariosTabContent extends StatelessWidget {
  const _ScenariosTabContent({required this.state});

  final ScenariosState state;

  void _openConversation(BuildContext context, ScenarioItem scenario) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (_) => AiConversationView(scenario: scenario),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ScenariosLevelFilter(levelBadge: state.levelBadge),
        const SizedBox(height: AppDimensions.spaceLg),
        for (var r = 0; r < state.scenarioRows.length; r++) ...[
          if (r > 0) const SizedBox(height: AppDimensions.spaceLg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var c = 0; c < state.scenarioRows[r].length; c++) ...[
                if (c > 0) const SizedBox(width: AppDimensions.spaceMd),
                Expanded(
                  child: ScenarioGridCard(
                    item: state.scenarioRows[r][c],
                    onTap: () =>
                        _openConversation(context, state.scenarioRows[r][c]),
                  ),
                ),
              ],
              if (state.scenarioRows[r].length == 1)
                const Expanded(child: SizedBox.shrink()),
            ],
          ),
        ],
        const SizedBox(height: AppDimensions.spaceLg),
        CustomText(
          AppStrings.scenariosFooter,
          style: AppTextStyles.caption,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
