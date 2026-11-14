import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/widgets/custom_app_bar.dart';
import '../../../core/widgets/custom_bottom_nav_bar.dart';
import '../viewmodels/leaderboard_cubit.dart';
import '../viewmodels/leaderboard_state.dart';
import '../widgets/leaderboard_period_tabs.dart';
import '../widgets/leaderboard_podium_card.dart';
import '../widgets/leaderboard_ranking_row.dart';
import '../widgets/leaderboard_table_header.dart';

/// Leaderboard screen View — UI only.
class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

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
      create: (_) => LeaderboardCubit(),
      child: const _LeaderboardViewBody(),
    );
  }
}

class _LeaderboardViewBody extends StatelessWidget {
  const _LeaderboardViewBody();

  void _onNavTap(BuildContext context, int index) {
    final cubit = context.read<LeaderboardCubit>();
    if (index == 0) {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      } else {
        cubit.selectTab(index);
      }
      return;
    }
    cubit.selectTab(index);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LeaderboardCubit, LeaderboardState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          appBar: CustomAppBar(
            title: AppStrings.leaderboardTitle,
            subtitle: AppStrings.leaderboardSubtitle,
            centerTitle: false,
            backgroundColor: AppColors.white,
            titleStyle: AppTextStyles.pageTitle,
            subtitleStyle: AppTextStyles.pageSubtitle,
            height: AppDimensions.appBarHeightLg,
            leadingWidth: 48,
            titleSpacing: AppDimensions.spaceMd,
            leading: IconButton(
              onPressed: () => Navigator.of(context).maybePop(),
              padding: const EdgeInsets.only(left: 12),
              icon: SvgPicture.asset(
                AppAssets.arrowLeft,
                width: AppDimensions.navIconSize,
                height: AppDimensions.navIconSize,
              ),
            ),
          ),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppDimensions.screenPadding,
              AppDimensions.screenPadding,
              AppDimensions.screenPadding,
              AppDimensions.spaceXl,
            ),
            children: [
              LeaderboardPeriodTabs(
                period: state.period,
                onChanged: context.read<LeaderboardCubit>().selectPeriod,
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              LeaderboardPodiumCard(
                caption: state.podiumCaption,
                topLearners: state.topLearners,
              ),
              const SizedBox(height: AppDimensions.spaceLg),
              const LeaderboardTableHeader(),
              const SizedBox(height: AppDimensions.spaceSm),
              for (var i = 0; i < state.ranking.length; i++) ...[
                if (i > 0) const SizedBox(height: AppDimensions.spaceXs),
                LeaderboardRankingRow(entry: state.ranking[i]),
              ],
            ],
          ),
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: state.selectedNavIndex,
            items: LeaderboardView._navItems,
            onTap: (index) => _onNavTap(context, index),
          ),
        );
      },
    );
  }
}
