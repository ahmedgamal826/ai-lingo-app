import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../../../core/theme/app_colors.dart';

import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class LegalLinks {
  static const String privacySecurity =
      'https://drive.google.com/file/d/1uH1yZxxpKFew27hiSlz5Sc3_Akg3OEtO/view?usp=sharing';
  static const String termsOfService =
      'https://drive.google.com/file/d/1vgesJ0Q0U4aCh9lPKXPLQK9_Ehn7eyRV/view?usp=sharing';
}

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  Future<void> _openPdf(
    BuildContext context,
    String url,
    String label,
  ) async {
    if (url.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Please add the Google Drive PDF link for $label in settings_view.dart',
          ),
        ),
      );
      return;
    }

    final uri = Uri.tryParse(url.trim());

    if (uri == null ||
        !uri.hasScheme ||
        !(uri.scheme == 'https' || uri.scheme == 'http')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('$label link is invalid.'),
        ),
      );
      return;
    }

    final opened = await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );

    if (!opened && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Could not open $label PDF.'),
        ),
      );
    }
  }

  void _showAbout(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.center,
              child: const SvgAssetIcon(
                'info',
                size: 25,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'AI Lingo',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 10,
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              'AI Lingo helps learners build language skills through guided practice and personalized learning. Practice vocabulary, improve your skills, and track your learning progress.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 11,
                height: 1.5,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
      builder: (context, s) {
        final c = context.read<LearnerProfileCubit>();
        final p = s.profile;

        return ProfilePage(
          title: 'Settings',
          child: ProfileBody(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SectionTitle('Notifications'),
                const SizedBox(height: AppDimensions.spaceSm),
                ProfileCard(
                  child: Column(
                    children: [
                      _switch(
                        'Practice reminders',
                        'Get reminders to keep your streak.',
                        p.notificationsEnabled,
                        c.toggleNotifications,
                      ),
                      const Divider(
                        color: AppColors.indicatorInactive,
                      ),
                      _switch(
                        'Weekly test updates',
                        'Stay updated with your weekly progress.',
                        p.weeklyReportEnabled,
                        c.toggleWeeklyReport,
                      ),
                      const Divider(
                        color: AppColors.indicatorInactive,
                      ),
                      _switch(
                        'Announcements',
                        'Receive important announcements.',
                        p.emailUpdatesEnabled,
                        c.toggleEmailUpdates,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppDimensions.spaceXl),
                const SectionTitle('General'),
                const SizedBox(height: AppDimensions.spaceSm),
                ProfileCard(
                  child: Column(
                    children: [
                      MenuTile(
                        assetIcon: 'shield-check',
                        title: 'Privacy & Security',
                        onTap: () {
                          _openPdf(
                            context,
                            LegalLinks.privacySecurity,
                            'Privacy & Security',
                          );
                        },
                      ),
                      MenuTile(
                        assetIcon: 'file-text',
                        title: 'Terms of Service',
                        onTap: () {
                          _openPdf(
                            context,
                            LegalLinks.termsOfService,
                            'Terms of Service',
                          );
                        },
                      ),
                      MenuTile(
                        assetIcon: 'info',
                        title: 'About AI Lingo',
                        onTap: () => _showAbout(context),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static Widget _switch(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: AppFontSizes.font11,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: AppFontSizes.font9,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: .78,
            child: Switch(
              value: value,
              onChanged: onChanged,
              activeColor: AppColors.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
