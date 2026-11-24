import '../models/quiz_models.dart';
import 'quizzes_service.dart';

/// In-memory implementation. Data lives as long as the app runs.
/// It is a singleton so the data survives when the Quizzes tab is rebuilt.
class MockQuizzesService implements QuizzesService {
  MockQuizzesService._() {
    _seed();
  }

  static final MockQuizzesService _instance = MockQuizzesService._();

  factory MockQuizzesService() => _instance;

  static const int targetQuestions = 20;
  static const List<String> _categories = [
    'Grammar',
    'Vocabulary',
    'Expressions',
  ];

  final List<Quiz> _quizzes = [];
  final Map<String, List<QuizQuestion>> _questions = {};
  int _nextId = 100;

  Future<void> _latency() =>
      Future<void>.delayed(const Duration(milliseconds: 250));

  // ---------------------------------------------------------------- seed

  void _seed() {
    _add(
      const Quiz(
        id: 'quiz-47',
        week: 'Week 47',
        title: 'Travel with Confidence',
        status: QuizStatus.scheduled,
        schedule: 'Nov 20, 9:00 AM – Nov 22, 8:00 PM',
        summary: '',
        description:
        'Practical English for airports, hotels, and exploring new places.',
        level: 'B1',
      ),
      20,
    );
    _add(
      const Quiz(
        id: 'quiz-46',
        week: 'Week 46',
        title: 'Everyday English',
        status: QuizStatus.closed,
        schedule: 'Nov 13, 9:00 AM – Nov 15, 8:00 PM',
        summary: '',
        description:
        'Grammar, vocabulary, and expressions for real-life conversations.',
        level: 'B1',
        submissions: 182,
        averageScore: 78,
      ),
      20,
    );
    _add(
      const Quiz(
        id: 'quiz-45',
        week: 'Week 45',
        title: 'The World of Work',
        status: QuizStatus.closed,
        schedule: 'Nov 6, 9:00 AM – Nov 8, 8:00 PM',
        summary: '',
        description: 'Vocabulary and phrases for the workplace.',
        level: 'B1',
        submissions: 174,
        averageScore: 81,
      ),
      20,
    );
    _add(
      const Quiz(
        id: 'quiz-48',
        week: 'Week 48',
        title: 'Connect & Converse',
        status: QuizStatus.draft,
        schedule: 'No schedule set',
        summary: '',
        description: 'Everyday conversation practice.',
        level: 'B1',
      ),
      12,
    );
  }

  void _add(Quiz quiz, int questionCount) {
    _quizzes.add(quiz);
    _questions[quiz.id] = _sampleQuestions(quiz.id, questionCount);
    _refresh(quiz.id);
  }

  List<QuizQuestion> _sampleQuestions(String quizId, int count) {
    return [
      for (var n = 1; n <= count; n++) _sample(quizId, n, count),
    ];
  }

  QuizQuestion _sample(String quizId, int n, int total) {
    final id = '$quizId-q$n';
    if (n == 1) {
      return QuizQuestion(
        id: id,
        number: n,
        total: total,
        category: 'Expressions',
        points: 5,
        text: 'Which is the most polite way to make a hotel reservation?',
        options: const [
          'I want room.',
          "I'd like to book a room, please.",
          'Give me room now.',
          'I booking room.',
        ],
        correctIndex: 1,
      );
    }
    if (n == 8) {
      return QuizQuestion(
        id: id,
        number: n,
        total: total,
        category: 'Grammar',
        points: 5,
        text: 'Choose the sentence that correctly describes a past experience.',
        options: const [
          'I have visited London last year.',
          'I visited London last year.',
          'I visit London last year.',
          'I had visit London last year.',
        ],
        correctIndex: 1,
      );
    }
    return QuizQuestion(
      id: id,
      number: n,
      total: total,
      category: _categories[n % 3],
      points: 5,
      text: 'Sample question $n: choose the correct answer.',
      options: [
        'Option A for question $n',
        'Option B for question $n',
        'Option C for question $n',
        'Option D for question $n',
      ],
      correctIndex: n % 4,
    );
  }

  // ------------------------------------------------------------- helpers

  String _summaryFor(Quiz quiz) {
    return switch (quiz.status) {
      QuizStatus.draft =>
      '${quiz.questionCount} of $targetQuestions questions ready',
      QuizStatus.scheduled =>
      '${quiz.questionCount} questions · ${quiz.durationMinutes} min · ${quiz.level}',
      QuizStatus.closed =>
      '${quiz.submissions} attempts · Average score ${quiz.averageScore}%',
    };
  }

  /// Recomputes question count, total points and the list summary of a quiz.
  void _refresh(String quizId) {
    final i = _quizzes.indexWhere((q) => q.id == quizId);
    if (i < 0) return;
    final questions = _questions[quizId] ?? const <QuizQuestion>[];
    var quiz = _quizzes[i].copyWith(
      questionCount: questions.length,
      totalPoints: questions.fold<int>(0, (sum, q) => sum + q.points),
    );
    quiz = quiz.copyWith(summary: _summaryFor(quiz));
    _quizzes[i] = quiz;
  }

  void _renumber(String quizId) {
    final list = _questions[quizId];
    if (list == null) return;
    for (var i = 0; i < list.length; i++) {
      list[i] = list[i].copyWith(number: i + 1, total: list.length);
    }
  }

  // ----------------------------------------------------------------- API

  @override
  Future<List<Quiz>> getQuizzes() async {
    await _latency();
    return List<Quiz>.of(_quizzes);
  }

  @override
  Future<Quiz> createQuiz(Quiz quiz) async {
    await _latency();
    final id = 'quiz-${_nextId++}';
    _quizzes.insert(0, quiz.copyWith(id: id));
    _questions[id] = [];
    _refresh(id);
    return _quizzes.firstWhere((q) => q.id == id);
  }

  @override
  Future<void> updateQuiz(Quiz quiz) async {
    await _latency();
    final i = _quizzes.indexWhere((q) => q.id == quiz.id);
    if (i < 0) throw StateError('Quiz not found');
    _quizzes[i] = quiz;
    _refresh(quiz.id);
  }

  @override
  Future<void> deleteQuiz(String quizId) async {
    await _latency();
    _quizzes.removeWhere((q) => q.id == quizId);
    _questions.remove(quizId);
  }

  @override
  Future<List<QuizQuestion>> getQuestions(String quizId) async {
    await _latency();
    return List<QuizQuestion>.of(_questions[quizId] ?? const []);
  }

  @override
  Future<QuizQuestion> saveQuestion(
      String quizId,
      QuizQuestion question,
      ) async {
    await _latency();
    final list = _questions.putIfAbsent(quizId, () => []);
    final id = question.id.isEmpty ? '$quizId-q${_nextId++}' : question.id;
    final saved = question.copyWith(id: id);
    final i = list.indexWhere((q) => q.id == id);
    if (i < 0) {
      list.add(saved);
    } else {
      list[i] = saved;
    }
    _renumber(quizId);
    _refresh(quizId);
    return list.firstWhere((q) => q.id == id);
  }

  @override
  Future<void> deleteQuestion(String quizId, String questionId) async {
    await _latency();
    _questions[quizId]?.removeWhere((q) => q.id == questionId);
    _renumber(quizId);
    _refresh(quizId);
  }
}