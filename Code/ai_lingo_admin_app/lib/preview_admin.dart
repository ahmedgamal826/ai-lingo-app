import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/theme/app_colors.dart';
import 'core/widgets/custom_bottom_nav_bar.dart';
import 'features/dashboard/views/dashboard_view.dart';
import 'features/quizzes/views/quizzes_view.dart';

// Local preview only: do NOT commit this file.
void main() => runApp(const _AdminPreview());

/// Makes the team's NavigationBar look like Figma (white bar, blue selected
/// item, no pill). The real app should put this in `app_theme.dart`.
final NavigationBarThemeData _figmaNavTheme = NavigationBarThemeData(
  backgroundColor: AppColors.white,
  surfaceTintColor: Colors.transparent,
  indicatorColor: Colors.transparent,
  elevation: 0,
  iconTheme: WidgetStateProperty.resolveWith(
        (states) => IconThemeData(
      size: 24,
      color: states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.textSecondary,
    ),
  ),
  labelTextStyle: WidgetStateProperty.resolveWith(
        (states) => TextStyle(
      fontSize: 10,
      fontWeight: FontWeight.w600,
      color: states.contains(WidgetState.selected)
          ? AppColors.primary
          : AppColors.textSecondary,
    ),
  ),
);

class _AdminPreview extends StatelessWidget {
  const _AdminPreview();

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(navigationBarTheme: _figmaNavTheme),
        home: child,
      ),
      child: const _PreviewShell(),
    );
  }
}

class _PreviewShell extends StatefulWidget {
  const _PreviewShell();

  @override
  State<_PreviewShell> createState() => _PreviewShellState();
}

class _PreviewShellState extends State<_PreviewShell> {
  int _index = 0;

  static const List<Widget> _pages = [DashboardView(), QuizzesView()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _index < _pages.length
          ? _pages[_index]
          : const Center(child: Text('Coming soon')),
      bottomNavigationBar: CustomBottomNavBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        items: const [
          BottomNavItem(
            label: 'Dashboard',
            icon: Icons.grid_view_outlined,
            activeIcon: Icons.grid_view_rounded,
          ),
          BottomNavItem(label: 'Quizzes', icon: Icons.assignment_outlined),
          BottomNavItem(label: 'Complaints', icon: Icons.forum_outlined),
          BottomNavItem(
            label: 'Notifications',
            icon: Icons.notifications_none_rounded,
          ),
          BottomNavItem(label: 'Profile', icon: Icons.person_outline),
        ],
      ),
    );
  }
}