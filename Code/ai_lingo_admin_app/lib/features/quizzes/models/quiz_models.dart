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