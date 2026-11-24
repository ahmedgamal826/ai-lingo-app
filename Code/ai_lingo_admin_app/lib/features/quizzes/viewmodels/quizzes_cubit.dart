import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/quiz_models.dart';
import '../services/quizzes_service.dart';
import 'quizzes_state.dart';

class QuizzesCubit extends Cubit<QuizzesState> {
  QuizzesCubit(this._service) : super(const QuizzesState());

  final QuizzesService _service;

  Future<void> load() async {
    emit(state.copyWith(status: QuizzesStatus.loading));
    try {
      final quizzes = await _service.getQuizzes();
      if (isClosed) return;
      emit(QuizzesState(status: QuizzesStatus.success, quizzes: quizzes));
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: QuizzesStatus.failure,
          errorMessage: 'Could not load quizzes. Please try again.',
        ),
      );
    }
  }

  /// Reloads the list silently (no loading spinner).
  Future<void> _refresh() async {
    final quizzes = await _service.getQuizzes();
    if (isClosed) return;
    emit(QuizzesState(status: QuizzesStatus.success, quizzes: quizzes));
  }

  Quiz? quizById(String id) {
    for (final quiz in state.quizzes) {
      if (quiz.id == id) return quiz;
    }
    return null;
  }

  // ------------------------------------------------------------- quizzes

  Future<Quiz> createQuiz(Quiz quiz) async {
    final created = await _service.createQuiz(quiz);
    await _refresh();
    return created;
  }

  Future<void> updateQuiz(Quiz quiz) async {
    await _service.updateQuiz(quiz);
    await _refresh();
  }

  Future<void> deleteQuiz(String quizId) async {
    await _service.deleteQuiz(quizId);
    await _refresh();
  }

  // ----------------------------------------------------------- questions

  Future<List<QuizQuestion>> getQuestions(String quizId) =>
      _service.getQuestions(quizId);

  Future<QuizQuestion> saveQuestion(
      String quizId,
      QuizQuestion question,
      ) async {
    final saved = await _service.saveQuestion(quizId, question);
    await _refresh();
    return saved;
  }

  Future<void> deleteQuestion(String quizId, String questionId) async {
    await _service.deleteQuestion(quizId, questionId);
    await _refresh();
  }
}