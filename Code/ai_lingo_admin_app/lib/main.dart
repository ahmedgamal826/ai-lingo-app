import 'package:ai_lingo_admin_app/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/constants/app_strings.dart';
import 'features/profile/admin_profile_feature.dart';
import 'features/profile/widgets/profile_components.dart';
import 'features/quizzes/services/mock_quizzes_service.dart';
import 'features/quizzes/viewmodels/quizzes_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    // The QuizzesCubit lives above MaterialApp so every screen (dashboard,
    // quizzes tab, create quiz...) can read it.
    // TODO: replace MockQuizzesService() with the real API service later.
    BlocProvider<QuizzesCubit>(
      create: (_) => QuizzesCubit(MockQuizzesService())..load(),
      child: const AdminProfileFeatureProvider(child: MyApp()),
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
            scaffoldBackgroundColor: AdminColors.background,
            colorScheme: ColorScheme.fromSeed(
              seedColor: AdminColors.primary,
              primary: AdminColors.primary,
            ),
            fontFamily: 'Roboto',
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: AdminColors.ink,
            ),
          ),
          home: child,
          routes: {...adminProfileRoutes()},
        );
      },
      child: const LoginScreen(),
    );
  }
}