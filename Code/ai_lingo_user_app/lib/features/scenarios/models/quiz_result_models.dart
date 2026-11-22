import 'quiz_models.dart';

/// Optional administrator review adjustment applied after auto-scoring.
class AdminScoreAdjustment {
  const AdminScoreAdjustment({
    required this.reviewedQuestionNumber,
    required this.previousScore,
    required this.adjustedScore,
    required this.messageTitle,
    required this.messageBody,
  });

  final int reviewedQuestionNumber;
  final int previousScore;
  final int adjustedScore;
  final String messageTitle;
  final String messageBody;
}

class CategoryPerformance {
  const CategoryPerformance({
    required this.category,
    required this.earnedPoints,
    required this.maxPoints,
    this.feedback,
  });

  final String category;
  final int earnedPoints;
  final int maxPoints;
  final String? feedback;

  String get scoreLabel => '$earnedPoints/$maxPoints';

  bool get isPerfect => earnedPoints >= maxPoints && maxPoints > 0;
}

/// Completed weekly-quiz attempt derived from session answers (or demo data).
class QuizAttemptResult {
  const QuizAttemptResult({
    required this.weekLabel,
    required this.testTitle,
    required this.userName,
    required this.rawScore,
    required this.maxScore,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.timeTaken,
    required this.attemptNumber,
    required this.maxAttempts,
    required this.earnedPoints,
    required this.rank,
    required this.categories,
    required this.selectedAnswers,
    required this.startedAt,
    required this.endedAt,
    this.adminAdjustment,
    this.isDemoData = false,
  });

  final String weekLabel;
  final String testTitle;
  final String userName;
  final int rawScore;
  final int maxScore;
  final int correctAnswers;
  final int totalQuestions;
  final Duration timeTaken;
  final int attemptNumber;
  final int maxAttempts;
  final int earnedPoints;
  final int? rank;
  final List<CategoryPerformance> categories;
  final Map<String, String> selectedAnswers;
  final DateTime startedAt;
  final DateTime endedAt;
  final AdminScoreAdjustment? adminAdjustment;
  final bool isDemoData;

  int get displayScore => adminAdjustment?.adjustedScore ?? rawScore;

  String get scoreLabel => '$displayScore / $maxScore';

  String get correctAnswersLabel => '$correctAnswers/$totalQuestions';

  String get attemptUsedLabel => '$attemptNumber/$maxAttempts';

  String get timeTakenLabel {
    final minutes = timeTaken.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = timeTaken.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get encouragementMessage => "That's a strong finish, $userName!";

  String get pointsRankLabel {
    final points = '+$earnedPoints points';
    if (rank == null) return points;
    return '$points · Rank #$rank';
  }

  String get appBarSubtitle =>
      '${weekLabel.toUpperCase()} · ${testTitle.toUpperCase()}';

  bool get hasAdminAdjustment => adminAdjustment != null;
}

/// Builds [QuizAttemptResult] from a finished quiz session.
class QuizResultCalculator {
  QuizResultCalculator._();

  static const Map<String, String> _categoryFeedback = {
    'Grammar': 'Great use of past tenses.',
    'Vocabulary': 'Keep exploring phrasal verbs.',
    'Everyday expressions': 'Natural phrasing under pressure.',
  };

  static QuizAttemptResult fromSession({
    required QuizSessionConfig config,
    required Map<String, String> selectedAnswers,
    required DateTime startedAt,
    required DateTime endedAt,
    required String userName,
    int attemptNumber = 1,
    int maxAttempts = 1,
    int? rank,
    int? earnedPointsOverride,
    AdminScoreAdjustment? adminAdjustment,
    bool isDemoData = false,
  }) {
    var correctCount = 0;
    var rawScore = 0;
    final categoryEarned = <String, int>{};
    final categoryMax = <String, int>{};

    for (final question in config.questions) {
      categoryMax[question.category] =
          (categoryMax[question.category] ?? 0) + question.points;
      categoryEarned.putIfAbsent(question.category, () => 0);

      final selected = selectedAnswers[question.id];
      if (selected != null && selected == question.correctKey) {
        correctCount += 1;
        rawScore += question.points;
        categoryEarned[question.category] =
            (categoryEarned[question.category] ?? 0) + question.points;
      }
    }

    final categories = categoryMax.entries.map((entry) {
      final earned = categoryEarned[entry.key] ?? 0;
      final max = entry.value;
      final feedback = earned >= max ? null : _categoryFeedback[entry.key];
      return CategoryPerformance(
        category: entry.key,
        earnedPoints: earned,
        maxPoints: max,
        feedback: feedback,
      );
    }).toList();

    final timeTaken = endedAt.difference(startedAt);
    final safeTime = timeTaken.isNegative ? Duration.zero : timeTaken;

    return QuizAttemptResult(
      weekLabel: _weekLabelFromSubtitle(config.subtitle),
      testTitle: config.title,
      userName: userName,
      rawScore: rawScore,
      maxScore: config.totalPoints,
      correctAnswers: correctCount,
      totalQuestions: config.questions.length,
      timeTaken: safeTime,
      attemptNumber: attemptNumber,
      maxAttempts: maxAttempts,
      earnedPoints: earnedPointsOverride ?? config.totalPoints,
      rank: rank,
      categories: categories,
      selectedAnswers: Map<String, String>.from(selectedAnswers),
      startedAt: startedAt,
      endedAt: endedAt,
      adminAdjustment: adminAdjustment,
      isDemoData: isDemoData,
    );
  }

  static String _weekLabelFromSubtitle(String subtitle) {
    final parts = subtitle.split('·');
    if (parts.isEmpty) return subtitle.trim();
    return parts.first.trim();
  }
}
