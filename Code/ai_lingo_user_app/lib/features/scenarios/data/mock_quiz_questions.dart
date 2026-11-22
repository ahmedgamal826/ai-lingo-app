import '../models/quiz_models.dart';

/// Mock weekly-quiz questions for UI/state testing (not live backend data).
///
/// Distribution matches Results design totals:
/// Grammar 40 · Vocabulary 35 · Everyday expressions 25 (= 100).
class MockQuizQuestions {
  MockQuizQuestions._();

  static QuizSessionConfig buildSession() {
    return const QuizSessionConfig(
      title: 'Everyday English',
      subtitle: 'WEEK 46 · WEEKLY TEST',
      duration: Duration(minutes: 20),
      questions: _questions,
    );
  }

  static const List<QuizQuestion> _questions = [
    // Grammar (8 × 5 = 40)
    QuizQuestion(
      id: 'q1',
      category: 'Grammar',
      points: 5,
      prompt: 'Choose the sentence that correctly describes a past experience.',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'I am going to the park yesterday.'),
        QuizOption(key: 'B', text: 'I went to the park yesterday.'),
        QuizOption(key: 'C', text: 'I go to the park yesterday.'),
        QuizOption(key: 'D', text: 'I will go to the park yesterday.'),
      ],
    ),
    QuizQuestion(
      id: 'q2',
      category: 'Grammar',
      points: 5,
      prompt: 'Select the correct present perfect sentence.',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'She has finished her homework.'),
        QuizOption(key: 'B', text: 'She have finished her homework.'),
        QuizOption(key: 'C', text: 'She finishing her homework.'),
        QuizOption(key: 'D', text: 'She finish her homework.'),
      ],
    ),
    QuizQuestion(
      id: 'q3',
      category: 'Grammar',
      points: 5,
      prompt: 'Choose the correct comparative form.',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'This book is more better than that one.'),
        QuizOption(key: 'B', text: 'This book is better than that one.'),
        QuizOption(key: 'C', text: 'This book is gooder than that one.'),
        QuizOption(key: 'D', text: 'This book is most better than that one.'),
      ],
    ),
    QuizQuestion(
      id: 'q4',
      category: 'Grammar',
      points: 5,
      prompt: 'Choose the sentence that correctly describes a past experience.',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'I never travel abroad before.'),
        QuizOption(key: 'B', text: 'I have never traveled abroad before.'),
        QuizOption(key: 'C', text: 'I traveling abroad never.'),
        QuizOption(key: 'D', text: 'I am never travel abroad.'),
      ],
    ),
    QuizQuestion(
      id: 'q5',
      category: 'Grammar',
      points: 5,
      prompt: 'Choose the correct conditional sentence.',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'If it rains, we will stay indoors.'),
        QuizOption(key: 'B', text: 'If it will rain, we stay indoors.'),
        QuizOption(key: 'C', text: 'If it raining, we stayed indoors.'),
        QuizOption(key: 'D', text: 'If it rain, we staying indoors.'),
      ],
    ),
    QuizQuestion(
      id: 'q6',
      category: 'Grammar',
      points: 5,
      prompt: 'Choose the sentence with correct article usage.',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'She is a honest person.'),
        QuizOption(key: 'B', text: 'She is an honest person.'),
        QuizOption(key: 'C', text: 'She is honest person.'),
        QuizOption(key: 'D', text: 'She is the honest.'),
      ],
    ),
    QuizQuestion(
      id: 'q7',
      category: 'Grammar',
      points: 5,
      prompt: 'Select the correct passive voice sentence.',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'The letter was written by Maria.'),
        QuizOption(key: 'B', text: 'The letter wrote by Maria.'),
        QuizOption(key: 'C', text: 'The letter is write by Maria.'),
        QuizOption(key: 'D', text: 'The letter writing Maria.'),
      ],
    ),
    QuizQuestion(
      id: 'q8',
      category: 'Grammar',
      points: 5,
      prompt: 'Choose the correct reported speech.',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'He said he was tired.'),
        QuizOption(key: 'B', text: 'He said he is being tired yesterday.'),
        QuizOption(key: 'C', text: 'He said he tired.'),
        QuizOption(key: 'D', text: 'He said I am tired then.'),
      ],
    ),
    // Vocabulary (7 × 5 = 35)
    QuizQuestion(
      id: 'q9',
      category: 'Vocabulary',
      points: 5,
      prompt: 'Which word is closest in meaning to "accommodate"?',
      correctKey: 'C',
      options: [
        QuizOption(key: 'A', text: 'Ignore'),
        QuizOption(key: 'B', text: 'Reject'),
        QuizOption(key: 'C', text: 'Adapt or provide space for'),
        QuizOption(key: 'D', text: 'Argue with'),
      ],
    ),
    QuizQuestion(
      id: 'q10',
      category: 'Vocabulary',
      points: 5,
      prompt: 'What does "deadline" mean?',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'A type of meeting'),
        QuizOption(
          key: 'B',
          text: 'The latest time something must be finished',
        ),
        QuizOption(key: 'C', text: 'A workplace break'),
        QuizOption(key: 'D', text: 'A travel ticket'),
      ],
    ),
    QuizQuestion(
      id: 'q11',
      category: 'Vocabulary',
      points: 5,
      prompt: 'Which phrase is appropriate for ending a formal email?',
      correctKey: 'C',
      options: [
        QuizOption(key: 'A', text: 'See ya'),
        QuizOption(key: 'B', text: 'Bye bye'),
        QuizOption(key: 'C', text: 'Best regards'),
        QuizOption(key: 'D', text: 'Talk later'),
      ],
    ),
    QuizQuestion(
      id: 'q12',
      category: 'Vocabulary',
      points: 5,
      prompt: 'What is a synonym of "confident"?',
      correctKey: 'C',
      options: [
        QuizOption(key: 'A', text: 'Nervous'),
        QuizOption(key: 'B', text: 'Unsure'),
        QuizOption(key: 'C', text: 'Self-assured'),
        QuizOption(key: 'D', text: 'Confused'),
      ],
    ),
    QuizQuestion(
      id: 'q13',
      category: 'Vocabulary',
      points: 5,
      prompt: 'What does "schedule" mean?',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'A plan of times for activities'),
        QuizOption(key: 'B', text: 'A type of food'),
        QuizOption(key: 'C', text: 'A travel bag'),
        QuizOption(key: 'D', text: 'A classroom desk'),
      ],
    ),
    QuizQuestion(
      id: 'q14',
      category: 'Vocabulary',
      points: 5,
      prompt: 'Which word best completes: "Please ___ your seatbelt."?',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'open'),
        QuizOption(key: 'B', text: 'fasten'),
        QuizOption(key: 'C', text: 'borrow'),
        QuizOption(key: 'D', text: 'cancel'),
      ],
    ),
    QuizQuestion(
      id: 'q15',
      category: 'Vocabulary',
      points: 5,
      prompt: 'What does "polite" mean?',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'Showing good manners'),
        QuizOption(key: 'B', text: 'Being very loud'),
        QuizOption(key: 'C', text: 'Arriving late'),
        QuizOption(key: 'D', text: 'Ignoring others'),
      ],
    ),
    // Everyday expressions (5 × 5 = 25)
    QuizQuestion(
      id: 'q16',
      category: 'Everyday expressions',
      points: 5,
      prompt: 'In a restaurant, what is the most polite way to order?',
      correctKey: 'C',
      options: [
        QuizOption(key: 'A', text: 'Give me the pasta.'),
        QuizOption(key: 'B', text: 'I want pasta now.'),
        QuizOption(key: 'C', text: "I'd like the pasta, please."),
        QuizOption(key: 'D', text: 'Pasta.'),
      ],
    ),
    QuizQuestion(
      id: 'q17',
      category: 'Everyday expressions',
      points: 5,
      prompt: 'At the airport, what should you say to ask for directions?',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'Where gate is?'),
        QuizOption(key: 'B', text: 'Could you tell me where Gate 12 is?'),
        QuizOption(key: 'C', text: 'Gate now.'),
        QuizOption(key: 'D', text: 'You show gate.'),
      ],
    ),
    QuizQuestion(
      id: 'q18',
      category: 'Everyday expressions',
      points: 5,
      prompt: 'Which sentence uses polite disagreement?',
      correctKey: 'C',
      options: [
        QuizOption(key: 'A', text: "You're wrong."),
        QuizOption(key: 'B', text: 'That is nonsense.'),
        QuizOption(
          key: 'C',
          text: 'I see your point, but I have a different view.',
        ),
        QuizOption(key: 'D', text: 'No way.'),
      ],
    ),
    QuizQuestion(
      id: 'q19',
      category: 'Everyday expressions',
      points: 5,
      prompt: 'Which option best asks for clarification?',
      correctKey: 'B',
      options: [
        QuizOption(key: 'A', text: 'Say again.'),
        QuizOption(key: 'B', text: 'Could you explain that in another way?'),
        QuizOption(key: 'C', text: 'Whatever.'),
        QuizOption(key: 'D', text: 'I do not care.'),
      ],
    ),
    QuizQuestion(
      id: 'q20',
      category: 'Everyday expressions',
      points: 5,
      prompt: 'In a shop, how do you politely ask the price?',
      correctKey: 'A',
      options: [
        QuizOption(key: 'A', text: 'How much is this, please?'),
        QuizOption(key: 'B', text: 'Price now.'),
        QuizOption(key: 'C', text: 'Tell price.'),
        QuizOption(key: 'D', text: 'Cheap?'),
      ],
    ),
  ];
}
