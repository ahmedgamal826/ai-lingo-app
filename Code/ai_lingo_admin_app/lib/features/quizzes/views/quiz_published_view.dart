import 'package:flutter/material.dart';

import '../widgets/quiz_confirmation_body.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_success_banner.dart';

/// Quiz published: confirmation after scheduling.
class QuizPublishedView extends StatelessWidget {
  const QuizPublishedView({
    super.key,
    required this.week,
    required this.title,
    required this.opensText,
    required this.closesText,
  });

  /// e.g. "Week 47"
  final String week;

  /// e.g. "Travel with Confidence"
  final String title;

  /// e.g. "Nov 20 at 9:00 AM"
  final String opensText;

  /// e.g. "Nov 22 at 8:00 PM"
  final String closesText;

  void _backToQuizzes(BuildContext context) {
    Navigator.of(context).popUntil((route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return QuizScaffold(
      title: 'Quiz published',
      onBack: () => _backToQuizzes(context),
      body: QuizConfirmationBody(
        iconName: 'calendar-check',
        title: 'Ready for takeoff.',
        message: '$week: $title is published and scheduled.',
        buttonLabel: 'Back to Quizzes',
        onButtonTap: () => _backToQuizzes(context),
        child: QuizSuccessBanner(
          title: 'All set',
          message:
          'Opens $opensText. Closes $closesText (UTC). Learners will be notified automatically.',
        ),
      ),
    );
  }
}