import '../models/conversation_models.dart';
import '../models/scenario_models.dart';
import 'conversation_evaluation_service.dart';

/// Temporary evaluation builder used until a real AI evaluator exists.
///
/// Scores and feedback are heuristic / sample-based — not live Gemini output.
class MockConversationEvaluationService
    implements ConversationEvaluationService {
  MockConversationEvaluationService({
    this.latency = const Duration(milliseconds: 900),
  });

  final Duration latency;

  @override
  Future<ConversationEvaluation> evaluate({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
    required String levelLabel,
    required List<ConversationMessage> messages,
  }) async {
    await Future<void>.delayed(latency);

    final userMessages = messages.where((m) => m.isUser).toList();
    if (userMessages.isEmpty) {
      throw StateError('Cannot evaluate a conversation without user messages.');
    }

    final corrections = <GrammarCorrection>[];
    for (final message in userMessages) {
      final lower = message.text.toLowerCase();
      if (RegExp(
        r'would like (?!to\b)\w+',
        caseSensitive: false,
      ).hasMatch(message.text)) {
        final corrected = message.text.replaceFirst(
          RegExp(r'would like (?!to\b)', caseSensitive: false),
          'would like to ',
        );
        corrections.add(
          GrammarCorrection(
            badgeLabel: 'GRAMMAR · VERB FORM',
            originalText: message.text,
            correctedText: corrected,
            explanation: 'Use "would like to" before an action verb.',
          ),
        );
        break;
      }
      if (RegExp(r'\bi want\b', caseSensitive: false).hasMatch(message.text) &&
          !lower.contains('please')) {
        corrections.add(
          GrammarCorrection(
            badgeLabel: 'VOCABULARY · POLITENESS',
            originalText: message.text,
            correctedText: message.text.replaceFirst(
              RegExp(r'\bi want\b', caseSensitive: false),
              "I'd like",
            ),
            explanation:
                'In service situations, "I\'d like" sounds more polite than "I want".',
          ),
        );
        break;
      }
    }

    // Keep the Figma correction section populated for mock evaluations.
    if (corrections.isEmpty) {
      corrections.add(profile.coachingCorrection);
    }

    final turnBonus = (userMessages.length * 2).clamp(0, 10);
    final lengthBonus = userMessages
        .map((m) => m.text.trim().split(RegExp(r'\s+')).length)
        .fold<int>(0, (sum, words) => sum + (words >= 6 ? 2 : 0))
        .clamp(0, 8);

    // Sample totals aligned with Figma restaurant evaluation when possible.
    final grammar = profile.scenarioKey == 'restaurant'
        ? 85
        : (82 + turnBonus).clamp(70, 96);
    final vocabulary = profile.scenarioKey == 'restaurant'
        ? 90
        : (86 + (lengthBonus ~/ 2)).clamp(72, 97);
    final conversation = profile.scenarioKey == 'restaurant'
        ? 89
        : (84 + turnBonus).clamp(70, 96);
    final overall = profile.scenarioKey == 'restaurant'
        ? 88
        : ((grammar + vocabulary + conversation) / 3).round();

    final summary = overall >= 85
        ? 'You kept the conversation flowing naturally.'
        : overall >= 75
        ? 'Solid effort — a few tweaks will make replies smoother.'
        : 'Keep practicing short, polite replies in this scenario.';

    final coach = profile.scenarioKey == 'restaurant'
        ? 'Your polite requests were excellent. Keep practicing infinitives and add a follow-up question to make replies feel more natural.'
        : 'You stayed on topic and practiced useful phrases. Add one follow-up question next time to keep the conversation moving.';

    return ConversationEvaluation(
      overallScore: overall,
      overallSummary: summary,
      categoryScores: [
        CategoryScore(label: 'Grammar', score: grammar),
        CategoryScore(label: 'Vocabulary', score: vocabulary),
        CategoryScore(label: 'Conversation', score: conversation),
      ],
      corrections: corrections,
      coachFeedback: coach,
      suggestedPhrases: profile.suggestedPhrases,
      isMockEvaluation: true,
      scenario: scenario,
      levelLabel: levelLabel,
      categoryLabel: profile.categoryLabel,
    );
  }
}
