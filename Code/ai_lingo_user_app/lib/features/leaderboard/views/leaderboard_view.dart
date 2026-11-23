import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_app_bar.dart';
import '../../home/core/widgets/custom_bottom_nav_bar.dart';
import '../../home/views/main_shell_view.dart';
import '../viewmodels/leaderboard_cubit.dart';
import '../viewmodels/leaderboard_state.dart';
import '../widgets/leaderboard_period_tabs.dart';
import '../widgets/leaderboard_podium_card.dart';
import '../widgets/leaderboard_ranking_row.dart';
import '../widgets/leaderboard_table_header.dart';

/// Leaderboard screen View — UI only.
///
/// Opened with [Navigator.push] above [MainShellView]. Bottom-nav taps pop
/// with the target tab index so the shell can switch to the real section.
class LeaderboardView extends StatelessWidget {
  const LeaderboardView({super.key});

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
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop<int>(index);
      return;
    }
    context.read<LeaderboardCubit>().selectTab(index);
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
                        fit: BoxFit.contain,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
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
            items: MainShellView.navItems,
            onTap: (index) => _onNavTap(context, index),
          ),
        );
      },
    );
  }
}
