import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../complaints/views/complaints_view.dart';
import '../../notifications/views/broadcast_announcement_view.dart';
import '../../notifications/views/notifications_view.dart';
import '../../quizzes/models/quiz_models.dart';
import '../../quizzes/viewmodels/quizzes_cubit.dart';
import '../../quizzes/views/quiz_form_view.dart';
// import '../../quizzes/models/quiz_models.dart';
// import '../../quizzes/views/quiz_form_view.dart';
// import '../../notifications/views/notifications_view.dart';
import '../../quizzes/views/quiz_overview_view.dart';
import '../models/dashboard_models.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section_title.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/welcome_row.dart';

/// Admin dashboard. Works on its own (opened after login) and inside the
/// app shell. Every action opens its screen itself; the optional callbacks
/// let the shell override that (for example, to switch tabs instead).
class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    this.onCreateQuiz,
    this.onBroadcast,
    this.onComplaints,
    this.onNotifications,
    this.onSeeAll,
  });

  final VoidCallback? onCreateQuiz;
  final VoidCallback? onBroadcast;
  final VoidCallback? onComplaints;
  final VoidCallback? onNotifications;
  final VoidCallback? onSeeAll;

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

  void _push(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  void _openCreateQuiz(BuildContext context) {
    if (onCreateQuiz != null) {
      onCreateQuiz!();
      return;
    }
    _push(context, const QuizFormView.create());
  }

  void _openBroadcast(BuildContext context) {
    if (onBroadcast != null) {
      onBroadcast!();
      return;
    }
    _push(context, const BroadcastAnnouncementView());
  }

  void _openComplaints(BuildContext context) {
    if (onComplaints != null) {
      onComplaints!();
      return;
    }
    // ComplaintsView is a tab body (no Scaffold), so it gets a slim app bar
    // with a back button when opened on its own.
    _push(
      context,
      Scaffold(
        backgroundColor: _background,
        appBar: AppBar(
          toolbarHeight: 44.h,
          elevation: 0,
          scrolledUnderElevation: 0,
          backgroundColor: AppColors.white,
        ),
        body: const ComplaintsView(),
      ),
    );
  }

  void _openNotifications(BuildContext context) {
    if (onNotifications != null) {
      onNotifications!();
      return;
    }
    _push(context, const NotificationsView());
  }

  /// Opens the Quiz overview of "Week 46" (the quiz in the activity row).
  void _openWeek46(BuildContext context) {
    final quizzes = context.read<QuizzesCubit>().state.quizzes;
    Quiz? quiz;
    for (final q in quizzes) {
      if (q.week == 'Week 46') {
        quiz = q;
        break;
      }
    }
    if (quiz == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Quiz not found. Try again in a moment.')),
      );
      return;
    }
    _push(context, QuizOverviewView(quiz: quiz));
  }

  void _openActivity(BuildContext context, DashboardActivity activity) {
    switch (activity.iconName) {
      case 'message-square-warning':
        _openComplaints(context);
      case 'clipboard-check':
        _openWeek46(context);
    }
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
    // Scaffold gives the texts a Material ancestor (no yellow underlines)
    // when the dashboard is opened outside the shell.
    return Scaffold(
      backgroundColor: _background,
      body: Column(
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
                  onBellTap: () => _openNotifications(context),
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
                        onTap: () => _openBroadcast(context),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: QuickActionTile(
                        iconName: 'inbox',
                        label: 'Complaints',
                        onTap: () => _openComplaints(context),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                DashboardSectionTitle(
                  title: 'Recent activities',
                  actionLabel: 'See all',
                  onActionTap: () => _openNotifications(context),
                ),
                SizedBox(height: 12.h),
                RecentActivityCard(
                  activities: _activities,
                  onTap: (activity) => _openActivity(context, activity),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}