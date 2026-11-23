import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'viewmodels/admin_profile_cubit.dart';
import 'views/admin_profile_view.dart';
import 'views/edit_profile_view.dart';
import 'views/settings_view.dart';
import 'views/change_password_view.dart';
import 'views/logout_view.dart';

class AdminProfileFeatureProvider extends StatelessWidget {
  const AdminProfileFeatureProvider({super.key, required this.child});
  final Widget child;
  @override Widget build(BuildContext context) => BlocProvider(create: (_) => AdminProfileCubit(), child: child);
}

Map<String, WidgetBuilder> adminProfileRoutes() => {
  '/admin/profile': (_) => const AdminProfileView(),
  '/admin/profile/edit': (_) => const AdminEditProfileView(),
  '/admin/profile/settings': (_) => const AdminSettingsView(),
  '/admin/profile/password': (_) => const AdminChangePasswordView(),
  '/admin/profile/logout': (_) => const AdminLogoutView(),
};
