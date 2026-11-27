import 'package:flutter/material.dart';
import '../widgets/profile_components.dart';
import '..//widgets/custom_card.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class ComplaintCompletedView extends StatelessWidget {
  const ComplaintCompletedView({super.key});
  @override
  Widget build(BuildContext context) => ProfilePage(title: 'Complaints & Support', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [
      Expanded(child: Container(alignment: Alignment.center, padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: AppColors.indicatorInactive, borderRadius: BorderRadius.circular(8)), child: const Text('New complaint', style: TextStyle(fontSize: AppFontSizes.font10, color: AppColors.textSecondary)))),
      const SizedBox(width: AppDimensions.spaceSm),
      Expanded(child: Container(alignment: Alignment.center, padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(8)), child: const Text('My History', style: TextStyle(fontSize: AppFontSizes.font10, color: AppColors.primary, fontWeight: FontWeight.w600)))),
    ]),
    const SizedBox(height: 18),
    Container(width: double.infinity, padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: AppColors.successLight, borderRadius: BorderRadius.circular(10)),
      child: const Row(children: [
        SvgAssetIcon('circle-check', color: AppColors.success, size: 20),
        SizedBox(width: 9), Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Complaint submitted', style: TextStyle(fontSize: AppFontSizes.font12, fontWeight: FontWeight.w700, color: AppColors.success)),
          Text('Your request has been received. We’ll get back to you soon.', style: TextStyle(fontSize: AppFontSizes.font9, color: AppColors.success)),
        ])),
      ])),
    const SizedBox(height: 20),
    const SectionTitle('My complaints'),
    const SizedBox(height: 10),
    _ComplaintTile(title: 'Weekly test score looks incorrect', status: 'Pending', color: AppColors.warning, id: 'BC-1042', onTap: () => Navigator.pushNamed(context, '/profile/complaint-details')),
    const SizedBox(height: 10),
    _ComplaintTile(title: 'Conversation audio is not clear', status: 'In Progress', color: AppColors.primary, id: 'BC-1038', onTap: () => Navigator.pushNamed(context, '/profile/complaint-details')),
    const SizedBox(height: 10),
    _ComplaintTile(title: 'Unable to save a new word', status: 'Resolved', color: AppColors.success, id: 'BC-1029', onTap: () => Navigator.pushNamed(context, '/profile/complaint-details')),
    const SizedBox(height: AppDimensions.spaceXl),
    PrimaryButton(label: 'Submit New Complaint', onPressed: () => Navigator.pushNamed(context, '/profile/complaints')),
  ])));
}

class _ComplaintTile extends StatelessWidget {
  const _ComplaintTile({required this.title, required this.status, required this.color, required this.id, required this.onTap});
  final String title, status, id; final Color color; final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => InkWell(onTap: onTap, borderRadius: BorderRadius.circular(11), child: ProfileCard(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(children: [Expanded(child: Text(title, style: const TextStyle(fontSize: AppFontSizes.font11, fontWeight: FontWeight.w600, color: AppColors.textPrimary))),
      CustomStatusBadge(label: status, tone: status == 'Pending' ? CustomTone.warning : status == 'Resolved' ? CustomTone.success : CustomTone.info)]),
    const SizedBox(height: 7),
    Text('Request #$id  •  Submitted recently', style: const TextStyle(fontSize: AppFontSizes.font9, color: AppColors.textSecondary)),
  ]))); 
}
