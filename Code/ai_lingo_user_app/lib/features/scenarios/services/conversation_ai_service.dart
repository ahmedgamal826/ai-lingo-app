import '../models/conversation_models.dart';
import '../models/scenario_models.dart';

/// Contract for scenario conversation replies (Gemini/Firebase AI later).
abstract class ConversationAiService {
  PartnerAvailability get availability;

  Future<ConversationMessage> createOpeningMessage({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
  });

  Future<ConversationMessage> generateReply({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
    required List<ConversationMessage> history,
    required String userMessage,
  });
}
