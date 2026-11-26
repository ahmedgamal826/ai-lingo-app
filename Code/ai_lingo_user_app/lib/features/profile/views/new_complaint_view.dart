import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class NewComplaintView extends StatelessWidget {
  const NewComplaintView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, s) {
      final c = context.read<LearnerProfileCubit>();
      return ProfilePage(title: 'Complaints & Support', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: _tab('New complaint', true)),
          Expanded(child: InkWell(onTap: () => Navigator.pushNamed(context, '/profile/complaint-completed'), child: _tab('My History', false))),
        ]),
        const SizedBox(height: 22),
        const Text('How can we help you?', style: TextStyle(fontSize: AppFontSizes.font16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 6),
        const Text('Something not quite right? Tell us what happened and we’ll work to fix it.', style: TextStyle(fontSize: AppFontSizes.font10, color: AppColors.textSecondary, height: 1.5)),
        const SizedBox(height: 22),
        ProfileField(label: 'Subject', value: s.complaintTitle, hint: 'Briefly describe the issue', onChanged: c.setComplaintTitle),
        const SizedBox(height: AppDimensions.spaceLg),
        const Text('Category', style: TextStyle(fontSize: AppFontSizes.font11, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 7),
        ProfileDropdown(
          value: s.complaintCategory,
          options: const ['Quiz & Scoring', 'Account', 'Technical issue', 'Learning content', 'Other'],
          onChanged: c.setComplaintCategory,
          fontSize: AppFontSizes.font11,
        ),
        const SizedBox(height: AppDimensions.spaceLg),
        ProfileField(label: 'Description', value: s.complaintDescription, hint: 'Tell us more about the issue...', onChanged: c.setComplaintDescription, maxLines: 5),
        const SizedBox(height: AppDimensions.spaceXl),
        PrimaryButton(label: 'Submit Complaint', assetIcon: 'send', onPressed: () {
          c.submitComplaint();
          if (c.state.complaintSubmitted) Navigator.pushNamed(context, '/profile/complaint-completed');
          else ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(c.state.message ?? 'Please complete the form')));
        }),
      ])));
    },
  );
  static Widget _tab(String label, bool selected) => Container(
    alignment: Alignment.center, padding: const EdgeInsets.symmetric(vertical: 11),
    decoration: BoxDecoration(color: selected ? AppColors.primaryLight : AppColors.indicatorInactive,
      borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(fontSize: AppFontSizes.font10, fontWeight: FontWeight.w600, color: selected ? AppColors.primary : AppColors.textSecondary)),
  );
}
