
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../complaints/views/complaints_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../profile/views/admin_profile_view.dart';
<<<<<<< Updated upstream
import '../../notifications/views/notifications_view.dart';
import '../../quizzes/views/quizzes_view.dart';
=======
import '../../quizzes/services/mock_quizzes_service.dart';
import '../../quizzes/viewmodels/quizzes_cubit.dart';
import '../../quizzes/views/quiz_form_view.dart';
import '../../quizzes/views/quiz_overview_view.dart';
import '../../quizzes/views/quizzes_flow.dart';
>>>>>>> Stashed changes
import '../core/widgets/custom_bottom_nav_bar.dart';

/// Root admin shell with persistent bottom navigation.
class MainShellView extends StatefulWidget {
  const MainShellView({super.key});

  static const List<BottomNavItem> navItems = [
    BottomNavItem(
      label: AppStrings.navDashboard,
      iconAsset: AppAssets.layoutGrid,
    ),
    BottomNavItem(
      label: AppStrings.navQuizzes,
      iconAsset: AppAssets.clipboardCheck,
    ),
    BottomNavItem(
      label: AppStrings.navComplaints,
      iconAsset: AppAssets.messagesSquare,
    ),
    BottomNavItem(
      label: AppStrings.navNotifications,
      iconAsset: AppAssets.bell,
    ),
    BottomNavItem(label: AppStrings.navProfile, iconAsset: AppAssets.userRound),
  ];

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  int _selectedIndex = 0;
<<<<<<< Updated upstream

  late final List<Widget> _pages = [
    DashboardView(onNotifications: () => _selectTab(3)),
    const QuizzesView(),
    const ComplaintsView(),
    const NotificationsView(showBottomNavigationBar: false),
=======

  /// Lets the shell open pages inside the Quizzes tab's own Navigator.
  final GlobalKey<NavigatorState> _quizzesNavKey = GlobalKey<NavigatorState>();

  late final List<Widget> _pages = [
    DashboardView(
      onCreateQuiz: () => _openInQuizzesTab(const QuizFormView.create()),
      onOpenQuiz: (quiz) => _openInQuizzesTab(QuizOverviewView(quiz: quiz)),
      onComplaints: () => _selectTab(2),
      onNotifications: () => _selectTab(3),
      onSeeAll: () => _selectTab(2),
    ),
    QuizzesFlow(navigatorKey: _quizzesNavKey),
    const ComplaintsView(),
    const NotificationsView(showBottomNav: false),
>>>>>>> Stashed changes
    const AdminProfileView(),
  ];

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    if (index < 0 || index >= _pages.length) return;
    setState(() => _selectedIndex = index);
  }

  /// Switches to the Quizzes tab and opens [page] inside it. The Cubit is
  /// available there and the bottom navigation bar stays visible.
  void _openInQuizzesTab(Widget page) {
    _selectTab(1);
    final navigator = _quizzesNavKey.currentState;
    if (navigator == null) return;
    navigator.popUntil((route) => route.isFirst);
    navigator.push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    // The QuizzesCubit is provided here, above all tabs.
    // TODO: when the API is ready, replace MockQuizzesService() with the
    // real service.
    return BlocProvider<QuizzesCubit>(
      create: (_) => QuizzesCubit(MockQuizzesService())..load(),
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
