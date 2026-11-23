import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/admin_profile_cubit.dart';
import '../viewmodels/admin_profile_state.dart';
import '../widgets/profile_components.dart';

class AdminChangePasswordView extends StatelessWidget {
  const AdminChangePasswordView({super.key});
  @override Widget build(BuildContext context) => AdminPage(title: 'Change Password', child: BlocBuilder<AdminProfileCubit, AdminProfileState>(
    builder: (context, state) {
      final cubit = context.read<AdminProfileCubit>();
      return AdminBody(padding: const EdgeInsets.fromLTRB(13, 12, 13, 20), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text('A stronger password. A\nsafer workspace.', style: TextStyle(fontSize: 18, height: 1.25, fontWeight: FontWeight.w800, color: AdminColors.ink)),
        const SizedBox(height: 9), const Text("Choose a unique password you haven't used before.", style: TextStyle(fontSize: 9, color: AdminColors.muted)),
        const SizedBox(height: 15),
        AdminInput(label: 'Current Password', onChanged: cubit.setCurrentPassword, obscureText: !state.passwordVisible,
          suffix: IconButton(onPressed: cubit.togglePasswordVisibility, icon: AdminSvg(state.passwordVisible ? 'eye' : 'eye-off', size: 15, color: AdminColors.muted))),
        const SizedBox(height: 11),
        AdminInput(label: 'New Password', onChanged: cubit.setNewPassword, obscureText: !state.passwordVisible,
          suffix: IconButton(onPressed: cubit.togglePasswordVisibility, icon: AdminSvg(state.passwordVisible ? 'eye' : 'eye-off', size: 15, color: AdminColors.muted))),
        const SizedBox(height: 11),
        AdminInput(label: 'Confirm New Password', onChanged: cubit.setConfirmPassword, obscureText: !state.passwordVisible,
          suffix: IconButton(onPressed: cubit.togglePasswordVisibility, icon: AdminSvg(state.passwordVisible ? 'eye' : 'eye-off', size: 15, color: AdminColors.muted))),
        const SizedBox(height: 12),
        Container(width: double.infinity, padding: const EdgeInsets.all(11), decoration: BoxDecoration(color: AdminColors.green, borderRadius: BorderRadius.circular(10)),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [const AdminSvg('shield-check', size: 14, color: AdminColors.success), const SizedBox(width: 7),
              Text(state.passwordUpdated ? 'Password updated successfully' : state.newPassword.isEmpty ? 'Your new password is strong' : cubit.passwordIsStrong ? 'Your new password is strong' : 'Password needs improvement',
                style: const TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AdminColors.ink))]),
            const SizedBox(height: 5), const Text('✓ At least 8 characters\n✓ Uppercase, lowercase, number, and symbol',
              style: TextStyle(fontSize: 8, height: 1.5, color: AdminColors.muted)),
            if (state.confirmPassword.isNotEmpty && state.newPassword != state.confirmPassword)
              const Padding(padding: EdgeInsets.only(top: 4), child: Text('Passwords do not match', style: TextStyle(fontSize: 8, color: AdminColors.danger))),
          ])),
        const SizedBox(height: 54), AdminPrimaryButton(label: 'Update Password', onPressed: () {
          cubit.updatePassword(); if (cubit.state.passwordUpdated) ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')));
        }), const SizedBox(height: 9),
        SizedBox(width: double.infinity, height: 42, child: TextButton(onPressed: () => Navigator.pop(context),
          style: TextButton.styleFrom(backgroundColor: AdminColors.primaryLight, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
          child: const Text('Cancel', style: TextStyle(fontSize: 11, color: AdminColors.primary, fontWeight: FontWeight.w600)))),
      ]));
    }));
}
