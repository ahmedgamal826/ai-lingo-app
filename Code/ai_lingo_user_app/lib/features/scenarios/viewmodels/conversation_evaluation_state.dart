import '../models/conversation_models.dart';

class ConversationEvaluationState {
  const ConversationEvaluationState({required this.evaluation});

  final ConversationEvaluation evaluation;

  ConversationEvaluationState copyWith({ConversationEvaluation? evaluation}) {
    return ConversationEvaluationState(
      evaluation: evaluation ?? this.evaluation,
    );
  }
}
