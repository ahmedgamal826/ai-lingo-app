import '../models/quiz_models.dart';
import '../models/quiz_result_models.dart';

class WeeklyQuizState {
  const WeeklyQuizState({
    required this.config,
    required this.currentIndex,
    required this.selectedAnswers,
    required this.remaining,
    required this.status,
    required this.flaggedQuestionIds,
    required this.startedAt,
    this.result,
  });

  factory WeeklyQuizState.initial(QuizSessionConfig config) {
    return WeeklyQuizState(
      config: config,
      currentIndex: 0,
      selectedAnswers: const {},
      remaining: config.duration,
      status: QuizSessionStatus.inProgress,
      flaggedQuestionIds: const {},
      startedAt: DateTime.now(),
    );
  }

  final QuizSessionConfig config;
  final int currentIndex;
  final Map<String, String> selectedAnswers;
  final Duration remaining;
  final QuizSessionStatus status;
  final Set<String> flaggedQuestionIds;
  final DateTime startedAt;
  final QuizAttemptResult? result;

  int get totalQuestions => config.questions.length;

  QuizQuestion get currentQuestion => config.questions[currentIndex];

  String? get currentSelectedKey => selectedAnswers[currentQuestion.id];

  bool get isFirstQuestion => currentIndex == 0;

  bool get isLastQuestion => currentIndex >= totalQuestions - 1;

  double get progress =>
      totalQuestions == 0 ? 0 : (currentIndex + 1) / totalQuestions;

  String get questionCounterLabel =>
      'Question ${currentIndex + 1} of $totalQuestions';

  String get remainingLabel {
    final minutes = remaining.inMinutes
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final seconds = remaining.inSeconds
        .remainder(60)
        .toString()
        .padLeft(2, '0');
    final hours = remaining.inHours;
    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:$minutes:$seconds remaining';
    }
    return '$minutes:$seconds remaining';
  }

  bool isFlagged(String questionId) => flaggedQuestionIds.contains(questionId);

  WeeklyQuizState copyWith({
    QuizSessionConfig? config,
    int? currentIndex,
    Map<String, String>? selectedAnswers,
    Duration? remaining,
    QuizSessionStatus? status,
    Set<String>? flaggedQuestionIds,
    DateTime? startedAt,
    QuizAttemptResult? result,
  }) {
    return WeeklyQuizState(
      config: config ?? this.config,
      currentIndex: currentIndex ?? this.currentIndex,
      selectedAnswers: selectedAnswers ?? this.selectedAnswers,
      remaining: remaining ?? this.remaining,
      status: status ?? this.status,
      flaggedQuestionIds: flaggedQuestionIds ?? this.flaggedQuestionIds,
      startedAt: startedAt ?? this.startedAt,
      result: result ?? this.result,
    );
  }
}
