import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, s) => ProfilePage(title: 'Notifications', child: ProfileBody(child: Column(children: [
      Row(children: [
        Expanded(child: _filter('All', true)),
        const SizedBox(width: AppDimensions.spaceSm), Expanded(child: _filter('Unread • 2', false)),
      ]),
      const SizedBox(height: 18),
      if (!s.notificationsRead) ...[
        _notification('book-open', 'Practice reminder', 'It’s time for your daily English practice. Keep your streak going!', '10 min ago'),
        _notification('messages-square', 'New reply to your request', 'Our support team has replied to your complaint.', '2 hours ago'),
      ],
      _notification('trophy', 'Your Week 46 results are ready', 'Check your weekly progress and see how much you improved.', 'Yesterday'),
      _notification('sparkles', 'You’re on a 7-day streak!', 'Amazing work. Keep learning every day!', '2 days ago'),
      const SizedBox(height: 18),
      TextButton(onPressed: () => context.read<LearnerProfileCubit>().markNotificationsRead(),
        child: const Text('Mark all as read', style: TextStyle(fontSize: AppFontSizes.font11, color: AppColors.primary))),
    ]))),
  );

  static Widget _filter(String text, bool selected) => Container(padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(color: selected ? AppColors.primaryLight : AppColors.indicatorInactive, borderRadius: BorderRadius.circular(8)),
    child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: AppFontSizes.font10, color: selected ? AppColors.primary : AppColors.textSecondary)));
  static Widget _notification(String icon,  String title, String body, String time) => Container(
    margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: AppColors.primaryLight.withOpacity(.65), borderRadius: BorderRadius.circular(11)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 28, height: 28, decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(9)), child: SvgAssetIcon(icon, size: 14, color: AppColors.primary)),
      const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: AppFontSizes.font11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 5), Text(body, style: const TextStyle(fontSize: AppFontSizes.font10, height: 1.45, color: AppColors.textSecondary)),
        const SizedBox(height: 6), Text(time, style: const TextStyle(fontSize: AppFontSizes.font9, color: AppColors.textSecondary)),
      ])),
    ]),
  );
}
