import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'viewmodels/learner_profile_cubit.dart';
import 'views/learner_profile_view.dart';
import 'views/edit_profile_view.dart';
import 'views/learning_preferences_view.dart';
import 'views/settings_view.dart';
import 'views/new_complaint_view.dart';
import 'views/complaint_completed_view.dart';
import 'views/complaint_details_view.dart';
import 'views/notifications_view.dart';
import 'views/logout_view.dart';

/// Place this provider above the app's existing Navigator so Cubit state is
/// shared by all profile feature routes.
class ProfileFeatureProvider extends StatelessWidget {
  const ProfileFeatureProvider({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => LearnerProfileCubit(),
    child: child,
  );
}

/// Merge these entries into the routes map of the existing MaterialApp.
Map<String, WidgetBuilder> learnerProfileRoutes() => {
  '/profile': (_) => const LearnerProfileView(),
  '/profile/edit': (_) => const EditProfileView(),
  '/profile/preferences': (_) => const LearningPreferencesView(),
  '/profile/settings': (_) => const SettingsView(),
  '/profile/complaints': (_) => const NewComplaintView(),
  '/profile/complaint-completed': (_) => const ComplaintCompletedView(),
  '/profile/complaint-details': (_) => const ComplaintDetailsView(),
  '/profile/notifications': (_) => const NotificationsView(),
  '/profile/logout': (_) => const LogoutView(),
};
