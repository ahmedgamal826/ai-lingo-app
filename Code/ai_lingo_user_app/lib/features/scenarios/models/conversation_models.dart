import 'scenario_models.dart';

enum MessageSender { ai, user }

enum ConversationStatus { ready, active, evaluating, evaluated, error }

enum PartnerAvailability { demo, online, offline }

class ConversationMessage {
  const ConversationMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.createdAt,
  });

  final String id;
  final MessageSender sender;
  final String text;
  final DateTime createdAt;

  bool get isAi => sender == MessageSender.ai;
  bool get isUser => sender == MessageSender.user;
}

class ScenarioConversationProfile {
  const ScenarioConversationProfile({
    required this.scenarioKey,
    required this.displayTitle,
    required this.categoryLabel,
    required this.levelLabel,
    required this.partnerRole,
    required this.openingMessage,
    required this.hints,
    required this.replyBank,
    required this.suggestedPhrases,
    required this.coachingCorrection,
  });

  final String scenarioKey;
  final String displayTitle;
  final String categoryLabel;
  final String levelLabel;
  final String partnerRole;
  final String openingMessage;
  final List<String> hints;
  final List<String> replyBank;
  final List<String> suggestedPhrases;

  /// Mock-evaluator coaching tip when no live grammar hit is found.
  final GrammarCorrection coachingCorrection;

  String get appBarSubtitle => '${levelLabel.toUpperCase()} · CONVERSATION';

  String get evaluationSubtitle =>
      '${categoryLabel.toUpperCase()} · ${levelLabel.toUpperCase()}';
}

class GrammarCorrection {
  const GrammarCorrection({
    required this.badgeLabel,
    required this.originalText,
    required this.correctedText,
    required this.explanation,
  });

  final String badgeLabel;
  final String originalText;
  final String correctedText;
  final String explanation;
}

class CategoryScore {
  const CategoryScore({required this.label, required this.score});

  final String label;
  final int score;
}

class ConversationEvaluation {
  const ConversationEvaluation({
    required this.overallScore,
    required this.overallSummary,
    required this.categoryScores,
    required this.corrections,
    required this.coachFeedback,
    required this.suggestedPhrases,
    required this.isMockEvaluation,
    required this.scenario,
    required this.levelLabel,
    required this.categoryLabel,
  });

  final int overallScore;
  final String overallSummary;
  final List<CategoryScore> categoryScores;
  final List<GrammarCorrection> corrections;
  final String coachFeedback;
  final List<String> suggestedPhrases;
  final bool isMockEvaluation;
  final ScenarioItem scenario;
  final String levelLabel;
  final String categoryLabel;

  String get evaluationSubtitle =>
      '${categoryLabel.toUpperCase()} · ${levelLabel.toUpperCase()}';
}

class ConversationSession {
  const ConversationSession({
    required this.id,
    required this.scenario,
    required this.profile,
    required this.levelLabel,
    required this.messages,
    required this.status,
    required this.partnerAvailability,
    required this.currentHint,
    this.evaluation,
    this.errorMessage,
  });

  final String id;
  final ScenarioItem scenario;
  final ScenarioConversationProfile profile;
  final String levelLabel;
  final List<ConversationMessage> messages;
  final ConversationStatus status;
  final PartnerAvailability partnerAvailability;
  final String currentHint;
  final ConversationEvaluation? evaluation;
  final String? errorMessage;

  int get userMessageCount =>
      messages.where((message) => message.isUser).length;

  bool get canEvaluate =>
      userMessageCount > 0 &&
      status != ConversationStatus.evaluating &&
      evaluation == null;
}
