import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_colors.dart';
import 'core/theme/app_text_styles.dart';
import 'features/home/views/home_view.dart';

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
  runApp(const AiLingoApp());
}

class AiLingoApp extends StatelessWidget {
  const AiLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: AppTextStyles.fontFamily,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          primary: AppColors.primary,
        ),
        scaffoldBackgroundColor: AppColors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.white,
          foregroundColor: AppColors.textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
        ),
        textTheme: const TextTheme().apply(
          fontFamily: AppTextStyles.fontFamily,
          bodyColor: AppColors.textPrimary,
          displayColor: AppColors.textPrimary,
        ),
      ),
      home: const HomeView(),
    );
  }
}
