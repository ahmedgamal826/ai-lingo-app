import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/admin_profile_cubit.dart';
import '../viewmodels/admin_profile_state.dart';
import '../widgets/profile_components.dart';

class AdminEditProfileView extends StatelessWidget {
  const AdminEditProfileView({super.key});
  @override
  Widget build(BuildContext context) => AdminPage(
      title: 'Edit Profile',
      child: BlocBuilder<AdminProfileCubit, AdminProfileState>(
          builder: (context, state) => AdminBody(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                    Center(
                        child: Column(children: [
                      Container(
                          width: 64,
                          height: 64,
                          decoration: const BoxDecoration(
                              color: AppColors.primaryLight,
                              shape: BoxShape.circle),
                          alignment: Alignment.center,
                          child: const Text('JM',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 18))),
                      const SizedBox(height: 7),
                      const Text('Change Photo',
                          style: TextStyle(
                              fontSize: 9,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600)),
                    ])),
                    const SizedBox(height: 22),
                    AdminInput(
                        label: 'Full Name',
                        initialValue: state.profile.name,
                        onChanged:
                            context.read<AdminProfileCubit>().updateName),
                    const SizedBox(height: 14),
                    AdminInput(
                        label: 'Email',
                        initialValue: state.profile.email,
                        onChanged:
                            context.read<AdminProfileCubit>().updateEmail),
                    const SizedBox(height: 14),
                    const AdminInput(
                        label: 'Role', initialValue: 'Administrator'),
                    const SizedBox(height: 24),
                    AdminPrimaryButton(
                        label: 'Save Changes',
                        onPressed: () => Navigator.pop(context)),
                    const SizedBox(height: 9),
                    SizedBox(
                        width: double.infinity,
                        height: 42,
                        child: TextButton(
                            onPressed: () => Navigator.pop(context),
                            style: TextButton.styleFrom(
                                backgroundColor: AppColors.primaryLight,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(9))),
                            child: const Text('Cancel',
                                style: TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600)))),
                  ]))));
}
