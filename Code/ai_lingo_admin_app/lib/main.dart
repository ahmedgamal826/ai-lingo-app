import 'package:flutter/material.dart';
import 'features/profile/admin_profile_feature.dart';
import 'features/profile/widgets/profile_components.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AdminProfileFeatureProvider(child: AdminProfileApp()));
}

class AdminProfileApp extends StatelessWidget {
  const AdminProfileApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Admin Profile',
    theme: ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: AdminColors.background,
      colorScheme: ColorScheme.fromSeed(seedColor: AdminColors.primary, primary: AdminColors.primary),
      fontFamily: 'Roboto',
      appBarTheme: const AppBarTheme(backgroundColor: Colors.white, foregroundColor: AdminColors.ink),
    ),
    initialRoute: '/admin/profile',
    routes: adminProfileRoutes(),
  );
}
