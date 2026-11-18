/// Lifecycle of a weekly quiz as shown in the management list.
enum QuizStatus { scheduled, closed, draft }

/// One row in "Quiz management".
class Quiz {
  const Quiz({
    required this.week,
    required this.title,
    required this.status,
    required this.schedule,
    required this.summary,
  });

  /// e.g. "Week 47"
  final String week;
  final String title;
  final QuizStatus status;

  /// e.g. "Nov 20, 9:00 AM – Nov 22, 8:00 PM" or "No schedule set"
  final String schedule;

  /// e.g. "20 questions · 20 min · B1"
  final String summary;
}

/// One question in the quiz builder (Preview / Edit question).
class QuizQuestion {
  const QuizQuestion({
    required this.number,
    required this.total,
    required this.category,
    required this.points,
    required this.text,
    required this.options,
    required this.correctIndex,
  });

  /// e.g. 8 in "QUESTION 8 OF 20"
  final int number;
  final int total;
  final String category;
  final int points;
  final String text;

  /// The four answer options, in order (A, B, C, D).
  final List<String> options;

  /// Index of the correct option inside [options].
  final int correctIndex;
}
/// One learner row in "Test Results" (also used by "Adjust Score").
class QuizLearnerResult {
  const QuizLearnerResult({
    required this.name,
    required this.email,
    required this.initials,
    required this.score,
    required this.time,
    this.submittedOn = 'Nov 15',
    this.adjustment = 0,
    this.reason = '',
  });

  final String name;
  final String email;
  final String initials;

  /// Score out of 100 (after any manual adjustment).
  final int score;

  /// e.g. "12:08"
  final String time;
  final String submittedOn;

  /// Points added (or removed) by an admin. 0 = never adjusted.
  final int adjustment;
  final String reason;

  bool get isAdjusted => adjustment != 0;

  /// Score before any manual adjustment.
  int get originalScore => score - adjustment;

  String get firstName => name.split(' ').first;

  /// e.g. "12:08 · Submitted Nov 15" or "14:32 · Adjusted +5 pts"
  String get detail => isAdjusted
      ? '$time · Adjusted ${adjustment > 0 ? '+' : ''}$adjustment pts'
      : '$time · Submitted $submittedOn';

  QuizLearnerResult adjustedTo(int newScore, String newReason) {
    return QuizLearnerResult(
      name: name,
      email: email,
      initials: initials,
      score: newScore,
      time: time,
      submittedOn: submittedOn,
      adjustment: newScore - originalScore,
      reason: newReason,
    );
  }
}