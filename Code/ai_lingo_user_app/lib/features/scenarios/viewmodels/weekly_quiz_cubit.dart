import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/mock_quiz_questions.dart';
import '../models/quiz_models.dart';
import '../models/quiz_result_models.dart';
import 'weekly_quiz_state.dart';

/// ViewModel for an in-progress weekly quiz session.
class WeeklyQuizCubit extends Cubit<WeeklyQuizState> {
  WeeklyQuizCubit({
    QuizSessionConfig? config,
    this.userName = 'Alex',
    this.rank = 12,
  }) : super(
         WeeklyQuizState.initial(config ?? MockQuizQuestions.buildSession()),
       ) {
    _startTimer();
  }

  final String userName;
  final int? rank;
  Timer? _timer;

  void selectAnswer(String optionKey) {
    if (state.status != QuizSessionStatus.inProgress) return;
    final updated = Map<String, String>.from(state.selectedAnswers)
      ..[state.currentQuestion.id] = optionKey;
    emit(state.copyWith(selectedAnswers: updated));
  }

  void nextQuestion() {
    if (state.status != QuizSessionStatus.inProgress) return;
    if (state.isLastQuestion) {
      _finish(QuizSessionStatus.finished);
      return;
    }
    emit(state.copyWith(currentIndex: state.currentIndex + 1));
  }

  void previousQuestion() {
    if (state.status != QuizSessionStatus.inProgress) return;
    if (state.isFirstQuestion) return;
    emit(state.copyWith(currentIndex: state.currentIndex - 1));
  }

  void toggleFlagCurrentQuestion() {
    final id = state.currentQuestion.id;
    final flagged = Set<String>.from(state.flaggedQuestionIds);
    if (flagged.contains(id)) {
      flagged.remove(id);
    } else {
      flagged.add(id);
    }
    emit(state.copyWith(flaggedQuestionIds: flagged));
  }

  QuizAttemptResult? get completedResult => state.result;

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;
      if (state.status != QuizSessionStatus.inProgress) return;
      final next = state.remaining - const Duration(seconds: 1);
      if (next <= Duration.zero) {
        emit(state.copyWith(remaining: Duration.zero));
        _finish(QuizSessionStatus.timedOut);
        return;
      }
      emit(state.copyWith(remaining: next));
    });
  }

  void _finish(QuizSessionStatus status) {
    _timer?.cancel();
    _timer = null;
    final endedAt = DateTime.now();
    final elapsed = state.config.duration - state.remaining;
    final result = QuizResultCalculator.fromSession(
      config: state.config,
      selectedAnswers: state.selectedAnswers,
      startedAt: endedAt.subtract(
        elapsed < Duration.zero ? Duration.zero : elapsed,
      ),
      endedAt: endedAt,
      userName: userName,
      attemptNumber: 1,
      maxAttempts: 1,
      rank: rank,
      earnedPointsOverride: state.config.totalPoints,
    );
    emit(state.copyWith(status: status, result: result));
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
