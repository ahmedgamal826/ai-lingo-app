import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../widgets/profile_components.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});
  @override
  Widget build(BuildContext context) => ProfilePage(title: 'Logout', child: Center(child: Padding(
    padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 56, height: 56, decoration: BoxDecoration(color: AppColors.primaryLight, borderRadius: BorderRadius.circular(18)),
        child: const SvgAssetIcon('log-out', color: AppColors.primary, size: 23)),
      const SizedBox(height: 20),
      const Text('See you soon, Alex!', style: TextStyle(fontSize: AppFontSizes.font17, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
      const SizedBox(height: AppDimensions.spaceSm),
      const Text('You have been safely logged out of your account.', textAlign: TextAlign.center,
        style: TextStyle(fontSize: AppFontSizes.font11, color: AppColors.textSecondary)),
      const SizedBox(height: AppDimensions.spaceXl),
      SizedBox(width: double.infinity, height: 44, child: OutlinedButton(
        onPressed: () { context.read<LearnerProfileCubit>().logout(); Navigator.popUntil(context, (r) => r.isFirst); },
        style: OutlinedButton.styleFrom(backgroundColor: AppColors.errorLight, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
        child: const Text('Logout', style: TextStyle(color: AppColors.danger, fontSize: AppFontSizes.font12, fontWeight: FontWeight.w700)))),
      const SizedBox(height: 10),
      PrimaryButton(label: 'Keep Learning', onPressed: () => Navigator.pop(context)),
    ]),
  )));
}
