import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../vocabulary/views/vocabulary_view.dart';
import '../widgets_core/custom_bottom_nav_bar.dart';
import '../widgets/progress_streak_card.dart';
import '../widgets/weekly_activity_card.dart';
import '../widgets/progress_stat_card.dart';
import '../widgets/conversation_score_card.dart';
import '../widgets/progress_level_caption.dart';

/// Progress screen built with the project's existing shared widgets.
class ProgressView extends StatefulWidget {
  const ProgressView({super.key, this.showBottomNav = true});

  final bool showBottomNav;

  @override
  State<ProgressView> createState() => _ProgressViewState();
}

class _ProgressViewState extends State<ProgressView> {
  int _selectedIndex = 3;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        navigationBarTheme: NavigationBarThemeData(
          height: AppDimensions.bottomNavHeight,
          backgroundColor: AppColors.white,
          indicatorColor: AppColors.primaryLight,
          labelTextStyle: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return TextStyle(
              fontSize: 10,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            );
          }),
          iconTheme: WidgetStateProperty.resolveWith((states) {
            final selected = states.contains(WidgetState.selected);
            return IconThemeData(
              size: 20,
              color: selected ? AppColors.primary : AppColors.textSecondary,
            );
          }),
        ),
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF7F8FC),
        appBar: AppBar(
          toolbarHeight: 78,
          backgroundColor: AppColors.white,
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          titleSpacing: 20,
          title: const Text(
            'Your progress',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        body: SafeArea(
          top: false,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const ProgressStreakCard(),
                const SizedBox(height: 12),
                const WeeklyActivityCard(),
                const SizedBox(height: 12),
                Row(
                  children: const [
                    Expanded(
                      child: ProgressStatCard(
                        iconAsset: 'chat_bubbles.svg',
                        value: '24',
                        label: 'Conversations completed',
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ProgressStatCard(
                        iconAsset: 'book-open.svg',
                        value: '128',
                        label: 'Words learned',
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                const ConversationScoreCard(),
                const SizedBox(height: 14),
                const ProgressLevelCaption(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: (widget.showBottomNav ? CustomBottomNavBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            if (index == 2) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const VocabularyView()),
              );
              return;
            }
            if (index == 3) {
              setState(() => _selectedIndex = 3);
            }
          },
          items: [
            BottomNavItem(
              label: 'Home',
              icon: Icons.home_outlined,
            ),
            BottomNavItem(
              label: 'Practice',
              icon: Icons.forum_outlined,
              iconAsset: AppAssets.icon('messages-square.svg'),
            ),
            BottomNavItem(
              label: 'Vocabulary',
              icon: Icons.menu_book_outlined,
              iconAsset: AppAssets.icon('book-open.svg'),
            ),
            BottomNavItem(
              label: 'Progress',
              icon: Icons.bar_chart_outlined,
              iconAsset: AppAssets.icon('Progress.svg'),
            ),
            BottomNavItem(
              label: 'Profile',
              icon: Icons.person_outline,
              iconAsset: AppAssets.icon('user-round.svg'),
            ),
          ],
        ) : null),
      ),
    );
  }
}
