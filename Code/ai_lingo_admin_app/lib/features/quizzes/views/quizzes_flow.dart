import 'package:flutter/material.dart';

import 'quizzes_view.dart';

/// The Quizzes tab with its own Navigator.
///
/// Every quiz screen opened from the list is pushed inside this tab, so the
/// app shell's bottom navigation bar stays visible (as in Figma).
/// The shell should use `QuizzesFlow()` as the Quizzes tab body.
///
/// The [QuizzesCubit] is provided by the app shell (MainShellView), above all
/// tabs, so every screen inside this Navigator can read it.
///
/// [navigatorKey] lets the shell open a quiz page inside this tab from
/// somewhere else (for example from the Dashboard).
class QuizzesFlow extends StatelessWidget {
  const QuizzesFlow({super.key, this.navigatorKey});

  final GlobalKey<NavigatorState>? navigatorKey;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (_) => MaterialPageRoute<void>(
        builder: (_) => const QuizzesView(),
      ),
    );
  }
}
