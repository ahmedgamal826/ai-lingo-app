import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../viewmodels/home_cubit.dart';
import '../viewmodels/home_state.dart';
import '../../leaderboard/views/leaderboard_view.dart';
import '../../scenarios/views/scenarios_view.dart';
import '../widgets/daily_momentum_card.dart';
import '../widgets/home_scale.dart';
import '../widgets/home_section_header.dart';
import '../widgets/learner_overview_header.dart';
import '../widgets/learning_statistics_row.dart';
import '../widgets/saved_word_preview_card.dart';
import '../widgets/scenario_suggestion_card.dart';

/// Home screen View — UI only.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  static const List<BottomNavItem> _navItems = [
    BottomNavItem(label: AppStrings.navHome, iconAsset: AppAssets.house),
    BottomNavItem(
      label: AppStrings.navPractice,
      iconAsset: AppAssets.messagesSquare,
    ),
    BottomNavItem(
      label: AppStrings.navVocabulary,
      iconAsset: AppAssets.bookOpen,
    ),
    BottomNavItem(
      label: AppStrings.navProgress,
      iconAsset: AppAssets.chartNoAxesColumn,
    ),
    BottomNavItem(label: AppStrings.navProfile, iconAsset: AppAssets.userRound),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: const _HomeViewBody(),
    );
  }
}

class _HomeViewBody extends StatelessWidget {
  const _HomeViewBody();

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
                      onLeaderboardTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const LeaderboardView(),
                          ),
                        );
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
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.selectedNavIndex,
            items: HomeView._navItems,
            onTap: (index) {
              if (index == 1) {
                Navigator.of(context).push(
                  MaterialPageRoute<void>(
                    builder: (_) => const ScenariosView(),
                  ),
                );
                return;
              }
              context.read<HomeCubit>().selectTab(index);
            },
          ),
        );
      },
    );
  }
}
