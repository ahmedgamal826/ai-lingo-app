import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../profile/views/learner_profile_view.dart';
import '../../progress/views/progress_view.dart';
import '../../vocabulary/views/vocabulary_view.dart';
import '../../scenarios/views/scenarios_view.dart';
import '../core/widgets/custom_bottom_nav_bar.dart';

import 'home_view.dart';

/// Lets pushed screens (e.g. Leaderboard) request a main-tab change after pop.
class MainShellController extends InheritedWidget {
  const MainShellController({
    super.key,
    required this.selectTab,
    required super.child,
  });

  final ValueChanged<int> selectTab;

  static MainShellController? maybeOf(BuildContext context) {
    return context.getInheritedWidgetOfExactType<MainShellController>();
  }

  @override
  bool updateShouldNotify(MainShellController oldWidget) => false;
}

/// Root shell: keeps tab screens alive without recreating them on tab change.
class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  static const List<BottomNavItem> navItems = [
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
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  int _selectedIndex = 0;

  /// Same widget instances every rebuild so Flutter skips child rebuilds
  /// when [identical] matches in [Element.updateChild].
  late final List<Widget> _pages = [
    const HomeView(showBottomNav: false),
    const ScenariosView(showBottomNav: false),
    const VocabularyView(showBottomNav: false),
    const ProgressView(showBottomNav: false),
    const LearnerProfileView(showBottomNav: false),
  ];

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    if (index < 0 || index >= _pages.length) return;
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return MainShellController(
      selectTab: _selectTab,
      child: Scaffold(
        body: IndexedStack(index: _selectedIndex, children: _pages),
        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: _selectedIndex,
          items: MainShellView.navItems,
          onTap: _selectTab,
        ),
      ),
    );
  }
}
