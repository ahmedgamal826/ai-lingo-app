import 'package:flutter/material.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../complaints/views/complaints_view.dart';
import '../../dashboard/views/dashboard_view.dart';
import '../../profile/views/admin_profile_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../quizzes/views/quizzes_view.dart';
import '../../quizzes/services/mock_quizzes_service.dart';
import '../../quizzes/viewmodels/quizzes_cubit.dart';
import '../../quizzes/views/quiz_form_view.dart';
import '../../quizzes/views/quiz_overview_view.dart';
import '../../quizzes/views/quizzes_flow.dart';
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
    BottomNavItem(
      label: AppStrings.navProfile,
      iconAsset: AppAssets.userRound,
    ),
  ];

  @override
  State<MainShellView> createState() => _MainShellViewState();
}

class _MainShellViewState extends State<MainShellView> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    DashboardView(onNotifications: () => _selectTab(3)),
    const QuizzesView(),
    const ComplaintsView(),
    const NotificationsView(showBottomNavigationBar: false),
    const AdminProfileView(),
  ];

  void _selectTab(int index) {
    if (index == _selectedIndex) return;
    if (index < 0 || index >= _pages.length) return;

    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _selectedIndex,
        items: MainShellView.navItems,
        onTap: _selectTab,
      ),
    );
  }
}
