import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, s) => ProfilePage(title: 'Notifications', child: ProfileBody(child: Column(children: [
      Row(children: [
        Expanded(child: _filter('All', true)),
        const SizedBox(width: 8), Expanded(child: _filter('Unread • 2', false)),
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
        child: const Text('Mark all as read', style: TextStyle(fontSize: 11, color: ProfileColors.primary))),
    ]))),
  );

  static Widget _filter(String text, bool selected) => Container(padding: const EdgeInsets.symmetric(vertical: 10),
    decoration: BoxDecoration(color: selected ? ProfileColors.primaryLight : const Color(0xFFF3F4F8), borderRadius: BorderRadius.circular(8)),
    child: Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 10, color: selected ? ProfileColors.primary : ProfileColors.muted)));
  static Widget _notification(String icon,  String title, String body, String time) => Container(
    margin: const EdgeInsets.only(bottom: 10), padding: const EdgeInsets.all(13),
    decoration: BoxDecoration(color: ProfileColors.primaryLight.withOpacity(.65), borderRadius: BorderRadius.circular(11)),
    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 34, height: 34, decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(9)), child: SvgAssetIcon(icon, size: 17, color: ProfileColors.primary)),
      const SizedBox(width: 10), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: ProfileColors.ink)),
        const SizedBox(height: 5), Text(body, style: const TextStyle(fontSize: 10, height: 1.45, color: ProfileColors.muted)),
        const SizedBox(height: 6), Text(time, style: const TextStyle(fontSize: 9, color: ProfileColors.muted)),
      ])),
    ]),
  );
}
