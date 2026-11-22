import '../models/quiz_result_models.dart';
import 'mock_quiz_questions.dart';

/// Demo completed attempt for Closed / Results UI when no live backend exists.
///
/// Answers are scored against [MockQuizQuestions] (not invented display-only
/// totals). Intended outcome matches the Figma Results sample: 18/20 → 90/100.
class MockQuizResult {
  MockQuizResult._();

  /// Wrong on Grammar q8 and Vocabulary q15 → 90 raw points (18 correct).
  static QuizAttemptResult buildDemo({
    String userName = 'Alex',
    int? rank = 12,
  }) {
    final config = MockQuizQuestions.buildSession();
    final answers = <String, String>{
      for (final question in config.questions) question.id: question.correctKey,
    };
    // Intentionally incorrect for the sample 90/100 breakdown.
    answers['q8'] = 'C';
    answers['q15'] = 'B';

    final endedAt = DateTime.now().subtract(const Duration(hours: 2));
    final startedAt = endedAt.subtract(
      const Duration(minutes: 14, seconds: 32),
    );

    return QuizResultCalculator.fromSession(
      config: config,
      selectedAnswers: answers,
      startedAt: startedAt,
      endedAt: endedAt,
      userName: userName,
      attemptNumber: 1,
      maxAttempts: 1,
      rank: rank,
      earnedPointsOverride: 100,
      isDemoData: true,
      adminAdjustment: const AdminScoreAdjustment(
        reviewedQuestionNumber: 8,
        previousScore: 85,
        adjustedScore: 90,
        messageTitle: 'Score updated by your administrator',
        messageBody:
            'Question 8 was reviewed. Your score was adjusted from 85 to 90',
      ),
    );
  }
}
