import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class NewComplaintView extends StatelessWidget {
  const NewComplaintView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, s) {
      final c = context.read<LearnerProfileCubit>();
      return ProfilePage(title: 'Complaints & Support', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(child: _tab('New complaint', true)),
          Expanded(child: InkWell(onTap: () => Navigator.pushNamed(context, '/profile/complaint-details'), child: _tab('My History', false))),
        ]),
        const SizedBox(height: 22),
        const Text('How can we help you?', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: ProfileColors.ink)),
        const SizedBox(height: 6),
        const Text('Something not quite right? Tell us what happened and we’ll work to fix it.', style: TextStyle(fontSize: 10, color: ProfileColors.muted, height: 1.5)),
        const SizedBox(height: 22),
        ProfileField(label: 'Subject', value: s.complaintTitle, hint: 'Briefly describe the issue', onChanged: c.setComplaintTitle),
        const SizedBox(height: 16),
        const Text('Category', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: ProfileColors.ink)),
        const SizedBox(height: 7),
        DropdownButtonFormField<String>(value: s.complaintCategory,
          items: ['Quiz & Scoring', 'Account', 'Technical issue', 'Learning content', 'Other'].map((v) => DropdownMenuItem(value: v, child: Text(v, style: const TextStyle(fontSize: 11)))).toList(),
          onChanged: (v) { if (v != null) c.setComplaintCategory(v); },
          decoration: const InputDecoration(isDense: true, border: OutlineInputBorder())),
        const SizedBox(height: 16),
        ProfileField(label: 'Description', value: s.complaintDescription, hint: 'Tell us more about the issue...', onChanged: c.setComplaintDescription, maxLines: 5),
        const SizedBox(height: 24),
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
    decoration: BoxDecoration(color: selected ? ProfileColors.primaryLight : const Color(0xFFF3F4F8),
      borderRadius: BorderRadius.circular(8)),
    child: Text(label, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: selected ? ProfileColors.primary : ProfileColors.muted)),
  );
}
