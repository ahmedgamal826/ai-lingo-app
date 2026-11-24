import '../models/quiz_models.dart';

enum QuizzesStatus { initial, loading, success, failure }

class QuizzesState {
  const QuizzesState({
    this.status = QuizzesStatus.initial,
    this.quizzes = const [],
    this.errorMessage,
  });

  final QuizzesStatus status;
  final List<Quiz> quizzes;
  final String? errorMessage;

  QuizzesState copyWith({
    QuizzesStatus? status,
    List<Quiz>? quizzes,
    String? errorMessage,
  }) {
    return QuizzesState(
      status: status ?? this.status,
      quizzes: quizzes ?? this.quizzes,
      errorMessage: errorMessage,
    );
  }
}