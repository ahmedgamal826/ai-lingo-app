import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/custom_card.dart';
import '../models/dashboard_models.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_section_title.dart';
import '../widgets/quick_action_tile.dart';
import '../widgets/recent_activity_card.dart';
import '../widgets/welcome_row.dart';

/// Admin dashboard tab. No Scaffold here: the app shell (with the bottom
/// navigation) will wrap it.
class DashboardView extends StatelessWidget {
  const DashboardView({super.key});

  // TODO: move to AppColors once the team agrees on a background color.
  static const Color _background = Color(0xFFF8F9FC);

  // Temporary sample data. The Cubit will provide the real values later.
  static const List<DashboardStat> _stats = [
    DashboardStat(
      title: 'Total Users',
      value: '1,248',
      icon: Icons.group_outlined,
      caption: '↑ 48 this week',
    ),
    DashboardStat(
      title: 'Active Users',
      value: '846',
      icon: Icons.person_outline,
      caption: '67.8% engagement',
    ),
    DashboardStat(
      title: 'Total Quizzes',
      value: '24',
      icon: Icons.assignment_outlined,
    ),
    DashboardStat(
      title: 'Pending Complaints',
      value: '8',
      icon: Icons.forum_outlined,
    ),
  ];

  static const List<DashboardActivity> _activities = [
    DashboardActivity(
      title: 'Alex Carter submitted a complaint',
      subtitle: '#C-1042 · Quiz & scoring · 13h ago',
      icon: Icons.chat_bubble_outline,
    ),
    DashboardActivity(
      title: 'Week 46 test closed',
      subtitle: '182 submissions · Nov 15, 8:00 PM',
      icon: Icons.assignment_turned_in_outlined,
    ),
  ];

  Widget _statCard(DashboardStat s) => CustomCard.stat(
    title: s.title,
    value: s.value,
    icon: s.icon,
    caption: s.caption,
  );

  Widget _statsRow(DashboardStat a, DashboardStat b) {
    return SizedBox(
      height: 148,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _statCard(a)),
          SizedBox(width: 12.w),
          Expanded(child: _statCard(b)),
        ],
      ),
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
child: const DashboardHeader(),
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
const Expanded(
child: QuickActionTile(
icon: Icons.add,
label: 'Create quiz',
),
),
SizedBox(width: 8.w),
const Expanded(
child: QuickActionTile(
icon: Icons.campaign_outlined,
label: 'Broadcast',
),
),
SizedBox(width: 8.w),
const Expanded(
child: QuickActionTile(
icon: Icons.inbox_outlined,
label: 'Complaints',
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