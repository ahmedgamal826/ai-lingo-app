import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/admin_profile_cubit.dart';
import '../viewmodels/admin_profile_state.dart';
import '../widgets/profile_components.dart';

class AdminSettingsView extends StatelessWidget {
  const AdminSettingsView({super.key});
  @override Widget build(BuildContext context) => AdminPage(title: 'Settings', child: BlocBuilder<AdminProfileCubit, AdminProfileState>(
    builder: (context, state) => AdminBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const AdminSectionTitle('Notifications'), const SizedBox(height: 10),
      AdminCard(padding: const EdgeInsets.fromLTRB(12, 7, 8, 7), child: Column(children: [
        AdminToggleRow(title: 'New complaints', subtitle: 'Stay on top of what matters', value: state.profile.newComplaints,
          onChanged: context.read<AdminProfileCubit>().toggleNewComplaints),
        const SizedBox(height: 5), AdminToggleRow(title: 'User activity', subtitle: 'Useful updates, right on time', value: state.profile.userActivity,
          onChanged: context.read<AdminProfileCubit>().toggleUserActivity),
        const SizedBox(height: 5), AdminToggleRow(title: 'System alerts', subtitle: 'Important news from Al-Lingo', value: state.profile.systemAlerts,
          onChanged: context.read<AdminProfileCubit>().toggleSystemAlerts),
      ])), const SizedBox(height: 18), const AdminSectionTitle('General'), const SizedBox(height: 10),
      AdminCard(padding: const EdgeInsets.fromLTRB(12, 6, 12, 6), child: Column(children: [
        _SettingsTile(icon: 'globe', title: 'App language', trailing: Text(state.profile.language, style: const TextStyle(fontSize: 8, color: AdminColors.primary)),
          onTap: () => _showLanguage(context)),
        const Divider(height: 1, color: AdminColors.line),
        _SettingsTile(icon: 'shield-check', title: 'Privacy & security', onTap: () => Navigator.pushNamed(context, '/admin/profile/password')),
        const Divider(height: 1, color: AdminColors.line),
        _SettingsTile(icon: 'file-text', title: 'Terms of Service', onTap: () {}),
        const Divider(height: 1, color: AdminColors.line),
        _SettingsTile(icon: 'info', title: 'About Al-Lingo', trailing: const Text('v1.0.0', style: TextStyle(fontSize: 8, color: AdminColors.primary)), onTap: () {}),
      ])),
      const SizedBox(height: 72), const Center(child: Text('Built for better conversations.\nYour preferences are saved automatically.',
        textAlign: TextAlign.center, style: TextStyle(fontSize: 8, height: 1.5, color: AdminColors.muted))),
    ]))));
}

void _showLanguage(BuildContext context) => showModalBottomSheet<void>(context: context, builder: (sheetContext) => SafeArea(child: Column(
  mainAxisSize: MainAxisSize.min, children: ['English', 'Arabic'].map((language) => ListTile(title: Text(language),
    onTap: () { context.read<AdminProfileCubit>().updateLanguage(language); Navigator.pop(sheetContext); })).toList())));

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({required this.icon, required this.title, required this.onTap, this.trailing});
  final String icon, title; final VoidCallback onTap; final Widget? trailing;
  @override Widget build(BuildContext context) => InkWell(onTap: onTap, child: SizedBox(height: 40, child: Row(children: [
    Container(width: 26, height: 26, decoration: BoxDecoration(color: AdminColors.primaryLight, borderRadius: BorderRadius.circular(8)),
      alignment: Alignment.center, child: AdminSvg(icon, size: 13)),
    const SizedBox(width: 10), Expanded(child: Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AdminColors.ink))),
    if (trailing != null) ...[trailing!, const SizedBox(width: 7)], const AdminSvg('chevron-right', size: 13, color: AdminColors.muted),
  ])));
}
