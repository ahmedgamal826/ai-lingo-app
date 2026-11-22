import 'package:flutter/material.dart';

import '../../vocabulary/views/vocabulary_view.dart';

/// App entry screen currently displays the Vocabulary screen.
class HomeView extends StatelessWidget {
  const HomeView({super.key, this.showBottomNav = true});

  /// When false, the root [MainShellView] owns the bottom navigation bar.
  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: _HomeViewBody(showBottomNav: showBottomNav),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody({required this.showBottomNav});

  final bool showBottomNav;

  @override
  Widget build(BuildContext context) {
    final horizontal = homeScale(context, AppDimensions.screenPadding);
    final sectionGap = homeScale(context, AppDimensions.spaceLg);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: AppStrings.appBarTitle,
            centerTitle: false,
            backgroundColor: AppColors.white,
            titleStyle: AppTextStyles.appBarTitle,
            height: AppDimensions.appBarHeightLg,
          ),
          body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(
              horizontal,
              horizontal,
              horizontal,
              homeScale(context, AppDimensions.spaceXl),
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxWidth: AppDimensions.designWidth,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    LearnerOverviewHeader(
                      initials: state.userInitials,
                      greeting: state.greeting,
                      levelLabel: state.levelLabel,
                      rankLabel: state.rankLabel,
                      unreadCount: state.unreadCount,
                      onLeaderboardTap: () async {
                        final tab = await Navigator.of(context).push<int>(
                          MaterialPageRoute<int>(
                            builder: (_) => const LeaderboardView(),
                          ),
                        );
                        if (!context.mounted || tab == null) return;
                        MainShellController.maybeOf(context)?.selectTab(tab);
                      },
                    ),
                    SizedBox(height: sectionGap),
                    DailyMomentumCard(
                      streakLabel: state.streakLabel,
                      progressLabel: state.progressLabel,
                      progressPercentLabel: state.progressPercentLabel,
                      progress: state.progressPercent / 100,
                    ),
                    SizedBox(height: sectionGap),
                    const HomeSectionHeader(
                      title: AppStrings.suggestedPracticeTitle,
                      actionLabel: AppStrings.viewAll,
                    ),
                    SizedBox(height: homeScale(context, 10)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        for (var i = 0; i < state.scenarios.length; i++) ...[
                          if (i > 0) SizedBox(width: homeScale(context, 10)),
                          Expanded(
                            child: ScenarioSuggestionCard(
                              scenario: state.scenarios[i],
                            ),
                          ),
                        ],
                      ],
                    ),
                    SizedBox(height: sectionGap),
                    const HomeSectionHeader(
                      title: AppStrings.vocabularyTitle,
                      actionLabel: AppStrings.seeAll,
                    ),
                    SizedBox(height: homeScale(context, AppDimensions.spaceSm)),
                    SavedWordPreviewCard(preview: state.savedWord),
                    SizedBox(height: sectionGap),
                    LearningStatisticsRow(stats: state.stats),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: showBottomNav
              ? CustomBottomNavBar(
                  currentIndex: state.selectedNavIndex,
                  items: MainShellView.navItems,
                  onTap: context.read<HomeCubit>().selectTab,
                )
              : null,
        );
      },
    );
  }
}
