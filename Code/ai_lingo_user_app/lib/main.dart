import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'features/home/views/home_view.dart';

void main() {
  runApp(const AiLingoApp());
}

class AiLingoApp extends StatelessWidget {
  const AiLingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      home: const HomeView(),
    );
  }
}
