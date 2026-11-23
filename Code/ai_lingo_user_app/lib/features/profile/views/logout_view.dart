import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodels/learner_profile_cubit.dart';
import '../widgets/profile_components.dart';

class LogoutView extends StatelessWidget {
  const LogoutView({super.key});
  @override
  Widget build(BuildContext context) => ProfilePage(title: 'Logout', child: Center(child: Padding(
    padding: const EdgeInsets.all(24), child: Column(mainAxisSize: MainAxisSize.min, children: [
      Container(width: 56, height: 56, decoration: BoxDecoration(color: ProfileColors.primaryLight, borderRadius: BorderRadius.circular(18)),
        child: const SvgAssetIcon('log-out', color: ProfileColors.primary, size: 23)),
      const SizedBox(height: 20),
      const Text('See you soon, Alex!', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: ProfileColors.ink)),
      const SizedBox(height: 8),
      const Text('You have been safely logged out of your account.', textAlign: TextAlign.center,
        style: TextStyle(fontSize: 11, color: ProfileColors.muted)),
      const SizedBox(height: 24),
      SizedBox(width: double.infinity, height: 44, child: OutlinedButton(
        onPressed: () { context.read<LearnerProfileCubit>().logout(); Navigator.popUntil(context, (r) => r.isFirst); },
        style: OutlinedButton.styleFrom(backgroundColor: ProfileColors.pink, side: BorderSide.none, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
        child: const Text('Logout', style: TextStyle(color: Color(0xFFEF718B), fontSize: 12, fontWeight: FontWeight.w700)))),
      const SizedBox(height: 10),
      PrimaryButton(label: 'Keep Learning', onPressed: () => Navigator.pop(context)),
    ]),
  )));
}
