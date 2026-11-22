enum QuizSessionStatus { ready, inProgress, finished, timedOut }

class QuizOption {
  const QuizOption({required this.key, required this.text});

  final String key;
  final String text;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.category,
    required this.points,
    required this.prompt,
    required this.options,
    required this.correctKey,
  });

  final String id;
  final String category;
  final int points;
  final String prompt;
  final List<QuizOption> options;
  final String correctKey;

  String get categoryBadgeLabel => '${category.toUpperCase()} · $points POINTS';
}

class QuizSessionConfig {
  const QuizSessionConfig({
    required this.title,
    required this.subtitle,
    required this.duration,
    required this.questions,
  });

  final String title;
  final String subtitle;
  final Duration duration;
  final List<QuizQuestion> questions;

  int get totalPoints =>
      questions.fold(0, (sum, question) => sum + question.points);
}
