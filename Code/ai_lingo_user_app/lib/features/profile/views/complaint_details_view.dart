import 'package:flutter/material.dart';
import '../widgets/profile_components.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class ComplaintDetailsView extends StatelessWidget {
  const ComplaintDetailsView({super.key});
  @override
  Widget build(BuildContext context) => ProfilePage(title: 'Request #BC-1042', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Align(alignment: Alignment.centerLeft, child: Container(padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4), decoration: BoxDecoration(color: AppColors.warningLight, borderRadius: BorderRadius.circular(20)), child: const Text('Pending', style: TextStyle(fontSize: AppFontSizes.font9, color: AppColors.warning, fontWeight: FontWeight.w700)))),
    const SizedBox(height: AppDimensions.spaceSm),
    const Text('Weekly test score looks incorrect', style: TextStyle(fontSize: AppFontSizes.font17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
    const SizedBox(height: 6),
    const Text('Request #BC-1042  •  14 Nov 2026', style: TextStyle(fontSize: AppFontSizes.font10, color: AppColors.textSecondary)),
    const SizedBox(height: 18),
    const ProfileCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Your message', style: TextStyle(fontSize: AppFontSizes.font11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      SizedBox(height: AppDimensions.spaceSm),
      Text('My score for the weekly test seems incorrect. I expected a higher score based on my answers.', style: TextStyle(fontSize: AppFontSizes.font11, height: 1.6, color: AppColors.textSecondary)),
    ])),
    const SizedBox(height: 14),
    const ProfileCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Support team', style: TextStyle(fontSize: AppFontSizes.font11, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      SizedBox(height: AppDimensions.spaceSm),
      Text('Thank you for reporting this. Our team is reviewing your request and will update you shortly.', style: TextStyle(fontSize: AppFontSizes.font11, height: 1.6, color: AppColors.textSecondary)),
    ])),
    const SizedBox(height: 20),
    PrimaryButton(label: 'Back to My Requests', onPressed: () => Navigator.pushNamed(context, '/profile/complaint-completed')),
  ])));
}
