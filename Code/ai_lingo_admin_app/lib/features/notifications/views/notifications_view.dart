import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../widgets/notification_card.dart';
import '../widgets/notification_data.dart';
import '../widgets/notification_section_header.dart';
import '../widgets/notifications_filter.dart';
import '../widgets/notifications_header.dart';
import '../widgets_core/custom_bottom_nav_bar.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key, this.showBottomNavigationBar = true});

  final bool showBottomNavigationBar;

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  int _selectedFilter = 0;
  int _selectedNav = 3;
  final List<NotificationData> _notifications = [
    NotificationData(
      title: 'New complaint from Alex Carter',
      category: '#C-1042 ┬╖ Quiz & scoring',
      description:
          "Weekly test score looks incorrect. Review the learner's question 8 result.",
      date: 'Nov 15 ┬╖ 8:12 PM',
      icon: 'message-square-warning.svg',
      unread: true,
      type: 'Unread',
    ),
    NotificationData(
      title: '48 new learners this week',
      category: 'User activity ┬╖ Weekly summary',
      description:
          '1,248 learners are now part of AI-Lingo. 846 have been active this week.',
      date: 'Nov 16 ┬╖ 8:00 AM',
      icon: 'users-round.svg',
      unread: true,
      type: 'Unread',
    ),
    NotificationData(
      title: 'Scheduled maintenance',
      category: 'System alert ┬╖ Important',
      description:
          'Audio services will be updated Nov 18, 2:00ΓÇô2:15 AM UTC.',
      date: 'Nov 16 ┬╖ 7:30 AM',
      icon: 'shield-alert.svg',
      unread: true,
      type: 'Important',
    ),
    NotificationData(
      title: 'Week 46 test has closed',
      category: 'Everyday English ┬╖ 182 submissions',
      description:
          'Results are ready for review. The average score is 78%.',
      date: 'Nov 15 ┬╖ 8:00 PM',
      icon: 'clipboard-check.svg',
      unread: false,
      type: 'Read',
    ),
  ];

  int get _unreadCount => _notifications.where((n) => n.unread).length;

  void _markAllRead() {
    setState(() {
      for (final item in _notifications) {
        item.unread = false;
        item.type = 'Read';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final visible = _selectedFilter == 1
        ? _notifications.where((n) => n.unread).toList()
        : _notifications;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            NotificationsHeader(onMarkAllRead: _markAllRead),
            Expanded(
              child: ListView(
                padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 20.h),
                children: [
                  NotificationsFilter(
                    selectedFilter: _selectedFilter,
                    unreadCount: _unreadCount,
                    onFilterChanged: (index) =>
                        setState(() => _selectedFilter = index),
                  ),
                  SizedBox(height: 14.h),
                  NotificationSectionHeader(onMarkAllRead: _markAllRead),
                  SizedBox(height: 12.h),
                  for (final item in visible) ...[
                    NotificationCard(
                      data: item,
                      onTap: () => setState(() => item.unread = false),
                    ),
                    SizedBox(height: 12.h),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: widget.showBottomNavigationBar
      // bottomNavigationBar: showBottomNavigationBar
          ? CustomBottomNavBar(
        currentIndex: _selectedNav,
        onTap: (index) => setState(() => _selectedNav = index),
        items: const [
          BottomNavItem(label: 'Dashboard', icon: Icons.dashboard_outlined, iconAsset: 'assets/icons/layout-dashboard.svg'),
          BottomNavItem(label: 'Quizzes', icon: Icons.assignment_outlined, iconAsset: 'assets/icons/clipboard-list.svg'),
          BottomNavItem(label: 'Complaints', icon: Icons.forum_outlined, iconAsset: 'assets/icons/messages-square.svg'),
          BottomNavItem(label: 'Notifications', icon: Icons.notifications_none, iconAsset: 'assets/icons/bell.svg'),
          BottomNavItem(label: 'Profile', icon: Icons.person_outline, iconAsset: 'assets/icons/user-round.svg'),
        ],
      )
          : null,
    );
  }
}
