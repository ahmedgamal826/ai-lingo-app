import '../models/quiz_result_models.dart';

enum WeeklyQuizResultsStatus { ready, error }

class WeeklyQuizResultsState {
  const WeeklyQuizResultsState({
    required this.result,
    this.status = WeeklyQuizResultsStatus.ready,
    this.errorMessage,
  });

  final QuizAttemptResult result;
  final WeeklyQuizResultsStatus status;
  final String? errorMessage;

  bool get hasAdminAdjustment => result.hasAdminAdjustment;

  WeeklyQuizResultsState copyWith({
    QuizAttemptResult? result,
    WeeklyQuizResultsStatus? status,
    String? errorMessage,
  }) {
    return WeeklyQuizResultsState(
      result: result ?? this.result,
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}
