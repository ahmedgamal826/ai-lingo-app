
import 'package:ai_lingo_admin_app/core/theme/app_colors.dart';
import 'package:ai_lingo_admin_app/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_strings.dart';
import 'features/profile/admin_profile_feature.dart';
import 'features/quizzes/services/mock_quizzes_service.dart';
import 'features/quizzes/viewmodels/quizzes_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    BlocProvider<QuizzesCubit>(
      create: (_) => QuizzesCubit(MockQuizzesService())..load(),
      child: const AdminProfileFeatureProvider(
        child: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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
          theme: ThemeData(
            useMaterial3: true,
            scaffoldBackgroundColor: AppColors.indicatorInactive ,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.primary,
              primary: AppColors.primary,
              surface: AppColors.white,
            ),
            fontFamily: 'Roboto',
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.white,
              foregroundColor: AppColors.textPrimary,
              elevation: 0,
            ),
          ),
          home: child,
          routes: {
            ...adminProfileRoutes(),
          },
        );
      },
      child: const LoginScreen(),
    );
  }
}
