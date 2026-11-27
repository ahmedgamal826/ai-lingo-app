import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../viewmodels/admin_profile_cubit.dart';
import '../viewmodels/admin_profile_state.dart';
import '../widgets/profile_components.dart';

class AdminSettingsView extends StatelessWidget {
  const AdminSettingsView({super.key});
  @override
  Widget build(BuildContext context) => AdminPage(
      title: 'Settings',
      child: BlocBuilder<AdminProfileCubit, AdminProfileState>(
          builder: (context, state) => AdminBody(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    const AdminSectionTitle('Notifications'),
                    const SizedBox(height: 10),
                    AdminCard(
                        padding: const EdgeInsets.fromLTRB(12, 7, 8, 7),
                        child: Column(children: [
                          AdminToggleRow(
                              title: 'New complaints',
                              subtitle: 'Stay on top of what matters',
                              value: state.profile.newComplaints,
                              onChanged: context
                                  .read<AdminProfileCubit>()
                                  .toggleNewComplaints),
                          const SizedBox(height: 5),
                          AdminToggleRow(
                              title: 'User activity',
                              subtitle: 'Useful updates, right on time',
                              value: state.profile.userActivity,
                              onChanged: context
                                  .read<AdminProfileCubit>()
                                  .toggleUserActivity),
                          const SizedBox(height: 5),
                          AdminToggleRow(
                              title: 'System alerts',
                              subtitle: 'Important news from Al-Lingo',
                              value: state.profile.systemAlerts,
                              onChanged: context
                                  .read<AdminProfileCubit>()
                                  .toggleSystemAlerts),
                        ])),
                    const SizedBox(height: 18),
                    const AdminSectionTitle('General'),
                    const SizedBox(height: 10),
                    AdminCard(
                        padding: const EdgeInsets.fromLTRB(12, 6, 12, 6),
                        child: Column(children: [
                          _SettingsTile(
                              icon: 'shield-check',
                              title: 'Privacy & security',
                              onTap: () => _openDocument(
                                  context,
                                  AdminLegalLinks.privacySecurity,
                                  'Privacy & security')),
                          const Divider(
                              height: 1, color: AppColors.indicatorInactive),
                          _SettingsTile(
                              icon: 'file-text',
                              title: 'Terms of Service',
                              onTap: () => _openDocument(
                                  context,
                                  AdminLegalLinks.termsOfService,
                                  'Terms of Service')),
                          const Divider(
                              height: 1, color: AppColors.indicatorInactive),
                          _SettingsTile(
                              icon: 'info',
                              title: 'About Al-Lingo',
                              trailing: const Text('v1.0.0',
                                  style: TextStyle(
                                      fontSize: 8, color: AppColors.primary)),
                              onTap: () => _showAbout(context)),
                        ])),
                    const SizedBox(height: 72),
                    const Center(
                        child: Text(
                            'Built for better conversations.\nYour preferences are saved automatically.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 8,
                                height: 1.5,
                                color: AppColors.textSecondary))),
                  ]))));
}

class AdminLegalLinks {
  static const String privacySecurity =
      'https://drive.google.com/file/d/1uH1yZxxpKFew27hiSlz5Sc3_Akg3OEtO/view?usp=sharing';
  static const String termsOfService =
      'https://drive.google.com/file/d/1vgesJ0Q0U4aCh9lPKXPLQK9_Ehn7eyRV/view?usp=sharing';
}

Future<void> _openDocument(
    BuildContext context, String link, String title) async {
  if (link.trim().isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('$title PDF link has not been added yet.')),
    );
    return;
  }
  final uri = Uri.tryParse(link.trim());
  if (uri == null || !uri.hasScheme) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Please add a valid Google Drive URL for $title.')),
    );
    return;
  }
  final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
  if (!opened && context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Could not open $title PDF.')),
    );
  }
}

void _showAbout(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16)),
            alignment: Alignment.center,
            child: const AdminSvg('info', size: 25),
          ),
          const SizedBox(height: 14),
          const Text('Al-Lingo',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary)),
          const SizedBox(height: 4),
          const Text('Version 1.0.0',
              style: TextStyle(fontSize: 10, color: AppColors.textSecondary)),
          const SizedBox(height: 12),
          const Text(
            'Al-Lingo helps learners build language skills through guided practice and personalized learning. Admins can manage learner support, monitor activity, and keep the learning experience running smoothly.',
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 11, height: 1.5, color: AppColors.textSecondary),
          ),
        ],
      ),
      actions: [
        TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close')),
      ],
    ),
  );
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile(
      {required this.icon,
      required this.title,
      required this.onTap,
      this.trailing});
  final String icon, title;
  final VoidCallback onTap;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => InkWell(
      onTap: onTap,
      child: SizedBox(
          height: 40,
          child: Row(children: [
            Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                    color: AppColors.primaryLight,
                    borderRadius: BorderRadius.circular(8)),
                alignment: Alignment.center,
                child: AdminSvg(icon, size: 13)),
            const SizedBox(width: 10),
            Expanded(
                child: Text(title,
                    style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary))),
            if (trailing != null) ...[trailing!, const SizedBox(width: 7)],
            const AdminSvg('chevron-right',
                size: 13, color: AppColors.textSecondary),
          ])));
}
