import 'package:flutter/material.dart';

import '../models/quiz_models.dart';
import '../widgets/quiz_confirmation_body.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_success_banner.dart';

/// Score updated: confirmation after an adjustment.
class QuizScoreUpdatedView extends StatelessWidget {
  const QuizScoreUpdatedView({
    super.key,
    required this.week,
    required this.learner,
    required this.fromScore,
  });

  /// e.g. "Week 46"
  final String week;

  /// The learner with the new score already applied.
  final QuizLearnerResult learner;
  final int fromScore;

  void _backToResults(BuildContext context) {
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return QuizScaffold(
      title: 'Score updated',
      onBack: () => _backToResults(context),
      body: QuizConfirmationBody(
        iconName: 'clipboard-check',
        title: 'A fair result.',
        message:
        "${learner.name}'s $week score has been updated from $fromScore to ${learner.score} out of 100.",
        buttonLabel: 'Back to Test Results',
        onButtonTap: () => _backToResults(context),
        // Temporary sample text. The Cubit will provide the real values.
        child: const QuizSuccessBanner(
          title: 'All set',
          message:
          'Leaderboard: #12 · 850 weekly points. Alex has been notified. Adjustment recorded by Jamie Morgan.',
        ),
      ),
    );
  }
}