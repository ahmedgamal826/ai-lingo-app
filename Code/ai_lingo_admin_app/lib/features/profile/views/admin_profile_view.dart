import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/admin_profile_cubit.dart';
import '../viewmodels/admin_profile_state.dart';
import '../widgets/profile_components.dart';

class AdminProfileView extends StatelessWidget {
  const AdminProfileView({super.key});
  @override Widget build(BuildContext context) => AdminPage(title: 'Profile', child: BlocBuilder<AdminProfileCubit, AdminProfileState>(
    builder: (context, state) => AdminBody(child: Column(children: [
      const SizedBox(height: 18),
      Container(width: 66, height: 66, decoration: const BoxDecoration(color: AdminColors.primaryLight, shape: BoxShape.circle),
        alignment: Alignment.center, child: const Text('JM', style: TextStyle(color: AdminColors.primary, fontSize: 19, fontWeight: FontWeight.w700))),
      const SizedBox(height: 10), Text(state.profile.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AdminColors.ink)),
      const SizedBox(height: 4), const Text('Administrator', style: TextStyle(fontSize: 10, color: AdminColors.muted)),
      const SizedBox(height: 22), AdminCard(child: Column(children: [
        _ProfileAction(icon: 'user-round-pen', title: 'Edit Profile', subtitle: 'Update your personal information', onTap: () => Navigator.pushNamed(context, '/admin/profile/edit')),
        const Divider(height: 18, color: AdminColors.line),
        _ProfileAction(icon: 'settings-2', title: 'Settings', subtitle: 'Manage your preferences', onTap: () => Navigator.pushNamed(context, '/admin/profile/settings')),
        const Divider(height: 18, color: AdminColors.line),
        _ProfileAction(icon: 'lock', title: 'Change Password', subtitle: 'Keep your account secure', onTap: () => Navigator.pushNamed(context, '/admin/profile/password')),
      ])),
      const SizedBox(height: 18), AdminPrimaryButton(label: 'Logout', pink: true, onPressed: () => Navigator.pushNamed(context, '/admin/profile/logout')),
    ]))));
}

class _ProfileAction extends StatelessWidget {
  const _ProfileAction({required this.icon, required this.title, required this.subtitle, required this.onTap});
  final String icon, title, subtitle; final VoidCallback onTap;
  @override Widget build(BuildContext context) => InkWell(onTap: onTap, child: Row(children: [
    Container(width: 30, height: 30, decoration: BoxDecoration(color: AdminColors.primaryLight, borderRadius: BorderRadius.circular(9)),
      alignment: Alignment.center, child: AdminSvg(icon, size: 15)),
    const SizedBox(width: 11), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AdminColors.ink)),
      const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 9, color: AdminColors.muted)),
    ])), const AdminSvg('chevron-right', size: 14, color: AdminColors.muted),
  ]));
}
