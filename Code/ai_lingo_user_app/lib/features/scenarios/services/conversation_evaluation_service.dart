import '../models/conversation_models.dart';
import '../models/scenario_models.dart';

/// Contract for scoring a finished conversation.
abstract class ConversationEvaluationService {
  Future<ConversationEvaluation> evaluate({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
    required String levelLabel,
    required List<ConversationMessage> messages,
  });
}
