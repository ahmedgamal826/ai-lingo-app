import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../viewmodels/learner_profile_state.dart';
import '../widgets/profile_components.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<LearnerProfileCubit, LearnerProfileState>(
    builder: (context, state) {
      final p = state.profile; final cubit = context.read<LearnerProfileCubit>();
      return ProfilePage(title: 'Edit Profile', child: ProfileBody(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Center(child: Column(children: [
          const AvatarCircle(initials: 'AC', size: 66),
          TextButton(onPressed: () {}, child: const Text('Change Photo', style: TextStyle(fontSize: 11, color: ProfileColors.primary))),
        ])),
        const SizedBox(height: 12),
        ProfileField(label: 'Full Name', value: p.fullName, onChanged: cubit.updateName),
        const SizedBox(height: 16),
        ProfileField(label: 'Email', value: p.email, onChanged: cubit.updateEmail),
        const SizedBox(height: 16),
        ProfileField(label: 'University', value: p.university, onChanged: cubit.updateUniversity),
        const SizedBox(height: 30),
        PrimaryButton(label: 'Save Changes', onPressed: () { cubit.saveProfile(); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile changes saved'))); }),
        const SizedBox(height: 10),
        SizedBox(width: double.infinity, height: 42, child: TextButton(onPressed: () => Navigator.pop(context),
          child: const Text('Cancel', style: TextStyle(color: ProfileColors.muted, fontSize: 12)))),
      ])));
    },
  );
}
