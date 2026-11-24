import '../models/quiz_models.dart';

/// Contract for everything the Quizzes feature needs from the data layer.
///
/// Today it is implemented by [MockQuizzesService] (in memory). When the API
/// is ready, create `ApiQuizzesService implements QuizzesService` and swap it
/// in `quizzes_flow.dart`. No screen needs to change.
abstract class QuizzesService {
  Future<List<Quiz>> getQuizzes();

  /// Creates the quiz and returns it with its new id.
  Future<Quiz> createQuiz(Quiz quiz);

  Future<void> updateQuiz(Quiz quiz);

  Future<void> deleteQuiz(String quizId);

  Future<List<QuizQuestion>> getQuestions(String quizId);

  /// Adds the question when [question.id] is empty, otherwise updates it.
  Future<QuizQuestion> saveQuestion(String quizId, QuizQuestion question);

  Future<void> deleteQuestion(String quizId, String questionId);
}