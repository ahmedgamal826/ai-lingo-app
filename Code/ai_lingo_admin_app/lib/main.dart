import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_strings.dart';
import 'features/notifications/views/notifications_view.dart';

void main() {
  runApp(const AiLingoAdminApp());
}

class AiLingoAdminApp extends StatelessWidget {
  const AiLingoAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const NotificationsView(),
    );
  }
}
