import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class LearnerProfileView extends StatelessWidget {
  const LearnerProfileView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, state) {
      final p = state.profile;
      return ProfilePage(title: 'Profile', back: false, child: Column(children: [
        Expanded(child: ProfileBody(child: Column(children: [
          const SizedBox(height: 14),
          AvatarCircle(initials: p.avatarInitials, size: 68),
          const SizedBox(height: 10),
          Text(p.fullName, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: ProfileColors.ink)),
          const SizedBox(height: 4),
          Text(p.university, style: const TextStyle(fontSize: 11, color: ProfileColors.muted)),
          const SizedBox(height: 6),
          _LevelBadge(level: p.level),
          const SizedBox(height: 22),
          ProfileCard(child: Column(children: [
            MenuTile(assetIcon: 'user-round-pen', title: 'Edit Profile', onTap: () => Navigator.pushNamed(context, '/profile/edit')),
            const Divider(height: 8, color: ProfileColors.line),
            MenuTile(assetIcon: 'sliders-horizontal', title: 'Learning Preferences', onTap: () => Navigator.pushNamed(context, '/profile/preferences')),
            const Divider(height: 8, color: ProfileColors.line),
            MenuTile(assetIcon: 'settings-2', title: 'Settings', onTap: () => Navigator.pushNamed(context, '/profile/settings')),
            const Divider(height: 8, color: ProfileColors.line),
            MenuTile(assetIcon: 'life-buoy', title: 'Complaints & Support', onTap: () => Navigator.pushNamed(context, '/profile/complaints')),
          ])),
          const SizedBox(height: 22),
          SizedBox(width: double.infinity, height: 44, child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/profile/logout'),
            style: OutlinedButton.styleFrom(backgroundColor: ProfileColors.pink, side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
            child: const Text('Logout', style: TextStyle(color: Color(0xFFEF718B), fontSize: 12, fontWeight: FontWeight.w700)),
          )),
        ]))),
        const BottomLearnerNav(),
      ]));
    },
  );
}

class _LevelBadge extends StatelessWidget {
  const _LevelBadge({required this.level});
  final String level;
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
    decoration: BoxDecoration(color: ProfileColors.primaryLight, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      const SvgAssetIcon('trophy', size: 12, color: ProfileColors.primary),
      const SizedBox(width: 5),
      Text('$level level', style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: ProfileColors.primary)),
    ]),
  );
}
