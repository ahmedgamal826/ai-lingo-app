import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../quizzes/views/quiz_form_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../models/dashboard_models.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section_title.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/welcome_row.dart';

/// Admin dashboard tab. No Scaffold here: the app shell (with the bottom
/// navigation) will wrap it.
class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    this.onCreateQuiz,
    this.onBroadcast,
    this.onComplaints,
    this.onNotifications,
  });

  /// Optional overrides. If [onCreateQuiz] is null, the dashboard opens the
  /// Create Quiz screen itself.
  final VoidCallback? onCreateQuiz;
  final VoidCallback? onBroadcast;
  final VoidCallback? onComplaints;
  final VoidCallback? onNotifications;

  // TODO: move to AppColors once the team agrees on a background color.
  static const Color _background = Color(0xFFF8F9FC);

  // Temporary sample data. The Cubit will provide the real values later.
  static const List<DashboardStat> _stats = [
    DashboardStat(
      title: 'Total Users',
      value: '1,248',
      iconName: 'users-round',
      caption: '↑ 48 this week',
    ),
    DashboardStat(
      title: 'Active Users',
      value: '846',
      iconName: 'user-round-check',
      caption: '67.8% engagement',
    ),
    DashboardStat(
      title: 'Total Quizzes',
      value: '24',
      iconName: 'clipboard-list',
    ),
    DashboardStat(
      title: 'Pending Complaints',
      value: '8',
      iconName: 'messages-square',
    ),
  ];

  static const List<DashboardActivity> _activities = [
    DashboardActivity(
      title: 'Alex Carter submitted a complaint',
      subtitle: '#C-1042 · Quiz & scoring · 13h ago',
      iconName: 'message-square-warning',
    ),
    DashboardActivity(
      title: 'Week 46 test closed',
      subtitle: '182 submissions · Nov 15, 8:00 PM',
      iconName: 'clipboard-check',
    ),
  ];

  void _openCreateQuiz(BuildContext context) {
    if (onCreateQuiz != null) {
      onCreateQuiz!();
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => const QuizFormView.create()),
    );
  }

  Widget _statsRow(DashboardStat a, DashboardStat b) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: DashboardStatCard(stat: a)),
        SizedBox(width: 12.w),
        Expanded(child: DashboardStatCard(stat: b)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // White app bar (matches Figma)
          ColoredBox(
            color: AppColors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                child: DashboardHeader(
                  onBellTap: onNotifications ??
                      () {
                        Navigator.of(context, rootNavigator: true).push(
                          MaterialPageRoute<void>(
                            builder: (_) => const NotificationsView(),
                          ),
                        );
                      },
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
              children: [
                const WelcomeRow(
                  initials: 'JM',
                  title: 'Good morning, Jamie',
                  subtitle: 'Monday, November 16',
                ),
                SizedBox(height: 16.h),
                _statsRow(_stats[0], _stats[1]),
                SizedBox(height: 12.h),
                _statsRow(_stats[2], _stats[3]),
                SizedBox(height: 20.h),
                const DashboardSectionTitle(title: 'Quick actions'),
                SizedBox(height: 12.h),
                Row(
                  children: [
                    Expanded(
                      child: QuickActionTile(
                        iconName: 'plus',
                        label: 'Create quiz',
                        onTap: () => _openCreateQuiz(context),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: QuickActionTile(
                        iconName: 'megaphone',
                        label: 'Broadcast',
                        onTap: onBroadcast,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: QuickActionTile(
                        iconName: 'inbox',
                        label: 'Complaints',
                        onTap: onComplaints,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                const DashboardSectionTitle(
                  title: 'Recent activities',
                  actionLabel: 'See all',
                ),
                SizedBox(height: 12.h),
                const RecentActivityCard(activities: _activities),
              ],
            ),
          ),
        ],
      ),
    );
  }
}