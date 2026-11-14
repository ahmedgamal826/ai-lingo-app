import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../../../core/widgets/custom_segmented_tabs.dart';
import '../../../core/widgets/custom_text.dart';
import '../models/scenario_models.dart';
import '../viewmodels/scenarios_cubit.dart';
import '../viewmodels/scenarios_state.dart';
import '../widgets/scenario_grid_card.dart';
import '../widgets/scenarios_level_filter.dart';

/// Practice Scenarios screen — UI only (Figma node 6:77413 content).
class ScenariosView extends StatelessWidget {
  const ScenariosView({super.key});

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

  static const List<SegmentedTabItem> _tabs = [
    SegmentedTabItem(id: 'scenarios', label: AppStrings.tabScenarios),
    SegmentedTabItem(id: 'weekly_test', label: AppStrings.tabWeeklyTest),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ScenariosCubit(),
      child: const _ScenariosViewBody(),
    );
  }
}

class _ScenariosViewBody extends StatelessWidget {
  const _ScenariosViewBody();

  void _onNavTap(BuildContext context, int index) {
    final cubit = context.read<ScenariosCubit>();
    if (index == 0) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        cubit.selectNav(index);
      }
      return;
    }
    if (index == 1) {
      cubit.selectNav(index);
      return;
    }
    cubit.selectNav(index);
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
          body: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.screenPadding,
              AppDimensions.screenPadding,
              AppDimensions.screenPadding,
              AppDimensions.spaceXl,
            ),
            children: [
              CustomSegmentedTabs(
                items: ScenariosView._tabs,
                selectedId: state.isScenariosTab ? 'scenarios' : 'weekly_test',
                onChanged: (id) {
                  context.read<ScenariosCubit>().selectTab(
                    id == 'weekly_test'
                        ? PracticeTab.weeklyTest
                        : PracticeTab.scenarios,
                  );
                },
              ),
              if (state.isScenariosTab) ...[
                const SizedBox(height: AppDimensions.spaceLg),
                ScenariosLevelFilter(levelBadge: state.levelBadge),
                const SizedBox(height: AppDimensions.spaceLg),
                for (var r = 0; r < state.scenarioRows.length; r++) ...[
                  if (r > 0) const SizedBox(height: AppDimensions.spaceLg),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (
                        var c = 0;
                        c < state.scenarioRows[r].length;
                        c++
                      ) ...[
                        if (c > 0) const SizedBox(width: AppDimensions.spaceMd),
                        Expanded(
                          child: ScenarioGridCard(
                            item: state.scenarioRows[r][c],
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
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.selectedNavIndex,
            items: ScenariosView._navItems,
            onTap: (index) => _onNavTap(context, index),
          ),
        );
      },
    );
  }
}
