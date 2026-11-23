import '../models/conversation_models.dart';
import '../models/scenario_models.dart';

class ConversationState {
  const ConversationState({
    required this.scenario,
    required this.profile,
    required this.levelLabel,
    required this.messages,
    required this.status,
    required this.partnerAvailability,
    required this.currentHintIndex,
    required this.isSending,
    required this.isAiTyping,
    this.evaluation,
    this.errorMessage,
  });

  factory ConversationState.initial({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
    required String levelLabel,
    required PartnerAvailability partnerAvailability,
  }) {
    return ConversationState(
      scenario: scenario,
      profile: profile,
      levelLabel: levelLabel,
      messages: const [],
      status: ConversationStatus.ready,
      partnerAvailability: partnerAvailability,
      currentHintIndex: 0,
      isSending: false,
      isAiTyping: false,
    );
  }

  final ScenarioItem scenario;
  final ScenarioConversationProfile profile;
  final String levelLabel;
  final List<ConversationMessage> messages;
  final ConversationStatus status;
  final PartnerAvailability partnerAvailability;
  final int currentHintIndex;
  final bool isSending;
  final bool isAiTyping;
  final ConversationEvaluation? evaluation;
  final String? errorMessage;

  String get currentHint {
    if (profile.hints.isEmpty) return '';
    return profile.hints[currentHintIndex % profile.hints.length];
  }

  int get userMessageCount =>
      messages.where((message) => message.isUser).length;

  bool get canSend =>
      !isSending &&
      !isAiTyping &&
      status != ConversationStatus.evaluating &&
      evaluation == null;

  bool get canEvaluate =>
      userMessageCount > 0 &&
      !isSending &&
      !isAiTyping &&
      status != ConversationStatus.evaluating &&
      evaluation == null;

  bool get isDemoPartner => partnerAvailability == PartnerAvailability.demo;

  ConversationState copyWith({
    ScenarioItem? scenario,
    ScenarioConversationProfile? profile,
    String? levelLabel,
    List<ConversationMessage>? messages,
    ConversationStatus? status,
    PartnerAvailability? partnerAvailability,
    int? currentHintIndex,
    bool? isSending,
    bool? isAiTyping,
    ConversationEvaluation? evaluation,
    String? errorMessage,
    bool clearError = false,
    bool clearEvaluation = false,
  }) {
    return ConversationState(
      scenario: scenario ?? this.scenario,
      profile: profile ?? this.profile,
      levelLabel: levelLabel ?? this.levelLabel,
      messages: messages ?? this.messages,
      status: status ?? this.status,
      partnerAvailability: partnerAvailability ?? this.partnerAvailability,
      currentHintIndex: currentHintIndex ?? this.currentHintIndex,
      isSending: isSending ?? this.isSending,
      isAiTyping: isAiTyping ?? this.isAiTyping,
      evaluation: clearEvaluation ? null : (evaluation ?? this.evaluation),
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
