import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class LearnerProfileView extends StatelessWidget {
  const LearnerProfileView({
    super.key,
    this.showBottomNav = true,
  });

  final bool showBottomNav;
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, state) {
      final p = state.profile;
      return ProfilePage(title: 'Profile', back: false, child: Column(children: [
        Expanded(child: ProfileBody(child: Column(children: [
          const SizedBox(height: 14),
          AvatarCircle(initials: p.avatarInitials, size: 68),
          const SizedBox(height: 10),
          Text(p.fullName, style: const TextStyle(fontSize: AppFontSizes.font17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
          const SizedBox(height: AppDimensions.spaceXs),
          Text(p.university, style: const TextStyle(fontSize: AppFontSizes.font11, color: AppColors.textSecondary)),
          const SizedBox(height: 6),
          _LevelBadge(level: p.level),
          const SizedBox(height: 22),
          ProfileCard(child: Column(children: [
  MenuTile(
    assetIcon: 'user-round-pen',
    title: 'Edit Profile',
    iconSize: 12,
    iconContainerSize: 24,
    onTap: () => Navigator.pushNamed(context, '/profile/edit'),
  ),
  const Divider(height: 8, color: AppColors.indicatorInactive),
  MenuTile(
    assetIcon: 'sliders-horizontal',
    title: 'Learning Preferences',
    iconSize: 12,
    iconContainerSize: 24,
    onTap: () => Navigator.pushNamed(context, '/profile/preferences'),
  ),
  const Divider(height: 8, color: AppColors.indicatorInactive),
  MenuTile(
    assetIcon: 'settings-2',
    title: 'Settings',
    iconSize: 12,
    iconContainerSize: 24,
    onTap: () => Navigator.pushNamed(context, '/profile/settings'),
  ),
  const Divider(height: 8, color: AppColors.indicatorInactive),
  MenuTile(
    assetIcon: 'life-buoy',
    title: 'Complaints & Support',
    iconSize: 12,
    iconContainerSize: 24,
    onTap: () => Navigator.pushNamed(context, '/profile/complaints'),
  ),
])),
          const SizedBox(height: 22),
          SizedBox(width: double.infinity, height: 44, child: OutlinedButton(
            onPressed: () => Navigator.pushNamed(context, '/profile/logout'),
            style: OutlinedButton.styleFrom(backgroundColor: AppColors.errorLight, side: BorderSide.none,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
            child: const Text('Logout', style: TextStyle(color: AppColors.danger, fontSize: AppFontSizes.font12, fontWeight: FontWeight.w700)),
          )),
        ]))),
                if (showBottomNav) const BottomLearnerNav(),
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
    decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(20)),
    child: Row(mainAxisSize: MainAxisSize.min, children: [
      const SvgAssetIcon('trophy', size: 12, color: AppColors.primary),
      const SizedBox(width: 5),
      Text('$level level', style: const TextStyle(fontSize: AppFontSizes.font9, fontWeight: FontWeight.w700, color: AppColors.primary)),
    ]),
  );
}
