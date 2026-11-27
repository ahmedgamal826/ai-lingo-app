import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/admin_profile_cubit.dart';
import '../viewmodels/admin_profile_state.dart';
import '../widgets/profile_components.dart';

class AdminLogoutView extends StatelessWidget {
  const AdminLogoutView({super.key});
  @override
  Widget build(BuildContext context) => AdminPage(
      title: 'Logout',
      child: BlocBuilder<AdminProfileCubit, AdminProfileState>(
          builder: (context, state) => Center(
              child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AdminCard(
                      padding: const EdgeInsets.fromLTRB(12, 13, 12, 12),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                width: 36,
                                height: 36,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    borderRadius: BorderRadius.circular(11)),
                                alignment: Alignment.center,
                                child: const AdminSvg('log-out', size: 17)),
                            const SizedBox(height: 13),
                            const Text('Signing off, Jamie?',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w800,
                                    color: AppColors.textPrimary)),
                            const SizedBox(height: 9),
                            const Text(
                                "You're about to log out of your admin account.\nYour changes have been saved.",
                                style: TextStyle(
                                    fontSize: 9,
                                    height: 1.5,
                                    color: AppColors.textSecondary)),
                            const SizedBox(height: 14),
                            AdminPrimaryButton(
                                label:
                                    state.isLoggedOut ? 'Logged Out' : 'Logout',
                                pink: true,
                                onPressed: () {
                                  context.read<AdminProfileCubit>().logout();
                                  Navigator.of(context)
                                      .popUntil((route) => route.isFirst);
                                }),
                            const SizedBox(height: 9),
                            SizedBox(
                                width: double.infinity,
                                height: 42,
                                child: ElevatedButton(
                                    onPressed: () => Navigator.pop(context),
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.primary,
                                        foregroundColor: Colors.white,
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(9))),
                                    child: const Text('Stay in My Workspace',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700)))),
                          ]))))));
}
