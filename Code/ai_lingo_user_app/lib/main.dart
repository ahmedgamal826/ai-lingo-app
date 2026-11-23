
import 'package:flutter/material.dart';

import 'features/profile/profile_feature.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    const ProfileFeatureProvider(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learner Profile',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF8F9FD),
        primaryColor: const Color(0xFF5B65FF),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B65FF),
          primary: const Color(0xFF5B65FF),
        ),
        fontFamily: 'Roboto',
      ),
      initialRoute: '/profile',
      routes: {
        ...learnerProfileRoutes(),
      },
    );
  }
}
