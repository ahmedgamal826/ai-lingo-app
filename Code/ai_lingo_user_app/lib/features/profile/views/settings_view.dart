import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, s) {
      final c = context.read<LearnerProfileCubit>(); final p = s.profile;
      return ProfilePage(title: 'Settings', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SectionTitle('Notifications'), const SizedBox(height: 8),
        ProfileCard(child: Column(children: [
          _switch('Practice reminders', 'Get reminders to keep your streak.', p.notificationsEnabled, c.toggleNotifications),
          const Divider(color: ProfileColors.line),
          _switch('Weekly test updates', 'Stay updated with your weekly progress.', p.weeklyReportEnabled, c.toggleWeeklyReport),
          const Divider(color: ProfileColors.line),
          _switch('Announcements', 'Receive important announcements.', p.emailUpdatesEnabled, c.toggleEmailUpdates),
        ])),
        const SizedBox(height: 24), const SectionTitle('General'), const SizedBox(height: 8),
        ProfileCard(child: Column(children: [
          MenuTile(assetIcon: 'globe', title: 'App Language', subtitle: p.language, onTap: () => Navigator.pushNamed(context, '/profile/preferences')),
          MenuTile(assetIcon: 'shield-check', title: 'Privacy & Security', onTap: () {}),
          MenuTile(assetIcon: 'file-text', title: 'Terms of Service', onTap: () {}),
          MenuTile(assetIcon: 'info', title: 'About App', onTap: () {}),
        ])),
      ])));
    },
  );

  static Widget _switch(String title, String subtitle, bool value, ValueChanged<bool> onChanged) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 3),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ProfileColors.ink)),
        const SizedBox(height: 3),
        Text(subtitle, style: const TextStyle(fontSize: 9, color: ProfileColors.muted)),
      ])),
      Transform.scale(scale: .78, child: Switch(value: value, onChanged: onChanged, activeColor: ProfileColors.primary, materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
    ]),
  );
}
