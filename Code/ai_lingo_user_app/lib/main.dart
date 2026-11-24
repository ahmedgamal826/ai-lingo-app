import 'package:ai_lingo_user_app/features/auth/views/splash_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_colors.dart';
import 'features/profile/profile_feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColors.white,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      systemNavigationBarDividerColor: AppColors.white,
    ),
  );
  runApp(
    const ProfileFeatureProvider(
      child: AiLingoApp(),
    ),
  );
}

class AiLingoApp extends StatelessWidget {
  const AiLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      // Width-based text scale so Android aspect ratios don't shrink
      // Inter sizes below the Figma 390pt design.
      minTextAdapt: false,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: AppStrings.appName,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            fontFamily: 'Inter',
            textTheme: ThemeData.light().textTheme.apply(
                  fontFamily: 'Inter',
                ),
          ),
          home: child,
          routes: {
            ...learnerProfileRoutes(),
          },
        );
      },
      child: const SplashScreen(),
    );
  }
}
