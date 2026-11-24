import 'package:flutter/material.dart';

import 'quizzes_view.dart';

/// The Quizzes tab with its own Navigator.
///
/// Every quiz screen opened from the list is pushed inside this tab, so the
/// app shell's bottom navigation bar stays visible (as in Figma).
///
/// The [QuizzesCubit] is provided at the top of the app (main.dart), so this
/// widget no longer creates one.
class QuizzesFlow extends StatelessWidget {
  const QuizzesFlow({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        builder: (_) => const QuizzesView(),
      ),
    );
  }
}