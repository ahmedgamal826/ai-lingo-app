import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../notifications/views/broadcast_announcement_view.dart';
import '../../quizzes/models/quiz_models.dart';
import '../../quizzes/views/quiz_form_view.dart';
<<<<<<< Updated upstream
import '../../notifications/views/notifications_view.dart';
=======
import '../../quizzes/views/quiz_overview_view.dart';
>>>>>>> Stashed changes
import '../models/dashboard_models.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section_title.dart';
import '../widgets/dashboard_stat_card.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/welcome_row.dart';

/// Admin dashboard tab. No Scaffold here: the app shell (with the bottom
/// navigation) wraps it.
class DashboardView extends StatelessWidget {
  const DashboardView({
    super.key,
    this.onCreateQuiz,
    this.onOpenQuiz,
    this.onQuizzes,
    this.onBroadcast,
    this.onComplaints,
    this.onNotifications,
<<<<<<< Updated upstream
=======
    this.onSeeAll,
>>>>>>> Stashed changes
  });

  /// "Create quiz" button. The app shell passes this so the create-quiz page
  /// opens inside the Quizzes tab (where the QuizzesCubit is available).
  /// If null, the dashboard pushes the page itself (preview use only).
  final VoidCallback? onCreateQuiz;

  /// Opens a quiz overview inside the Quizzes tab (used by the
  /// "Week 46 test closed" activity). If null, the dashboard pushes the
  /// page itself (preview use only).
  final void Function(Quiz quiz)? onOpenQuiz;

  /// Kept only so the app shell keeps compiling if it still passes it.
  final VoidCallback? onQuizzes;

  /// Optional override for "Broadcast". If null, the dashboard opens the
  /// broadcast screen itself.
  final VoidCallback? onBroadcast;

  /// Tab switches: the app shell owns the tabs, so it passes these.
  final VoidCallback? onComplaints;
  final VoidCallback? onNotifications;
<<<<<<< Updated upstream
=======
  final VoidCallback? onSeeAll;
>>>>>>> Stashed changes

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

  // Temporary sample quiz for the "Week 46 test closed" activity.
  static const Quiz _week46 = Quiz(
    week: 'Week 46',
    title: 'Everyday English',
    status: QuizStatus.closed,
    schedule: 'Nov 13, 9:00 AM – Nov 15, 8:00 PM',
    summary: '182 attempts · Average score 78%',
  );

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

  void _openWeek46(BuildContext context) {
    if (onOpenQuiz != null) {
      onOpenQuiz!(_week46);
      return;
    }
    _push(context, const QuizOverviewView(quiz: _week46));
  }

  void _openBroadcast(BuildContext context) {
    if (onBroadcast != null) {
      onBroadcast!();
      return;
    }
    _push(context, const BroadcastAnnouncementView());
  }

  void _onActivityTap(BuildContext context, DashboardActivity activity) {
    // Match by title (safer than indexOf, which can fail if the card passes
    // a copy of the object).
    if (activity.title == _activities[0].title) {
      // Complaint activity: open the Complaints tab.
      onComplaints?.call();
    } else if (activity.title == _activities[1].title) {
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
<<<<<<< Updated upstream
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
=======
                child: DashboardHeader(onBellTap: onNotifications),
>>>>>>> Stashed changes
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
                        onTap: onComplaints,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),
                DashboardSectionTitle(
                  title: 'Recent activities',
                  actionLabel: 'See all',
                  onActionTap: onSeeAll,
                ),
                SizedBox(height: 12.h),
                RecentActivityCard(
                  activities: _activities,
                  onTap: (activity) => _onActivityTap(context, activity),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
