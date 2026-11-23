import '../models/conversation_models.dart';
import '../models/scenario_models.dart';
import 'conversation_ai_service.dart';

/// Temporary local partner used until Gemini / Firebase AI Logic is wired.
///
/// Replies are scripted for the selected scenario — not live model output.
class MockConversationAiService implements ConversationAiService {
  MockConversationAiService({this.latency = const Duration(milliseconds: 700)});

  final Duration latency;
  int _replyIndex = 0;

  @override
  PartnerAvailability get availability => PartnerAvailability.demo;

  @override
  Future<ConversationMessage> createOpeningMessage({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
  }) async {
    await Future<void>.delayed(latency);
    return ConversationMessage(
      id: 'ai-open-${DateTime.now().microsecondsSinceEpoch}',
      sender: MessageSender.ai,
      text: profile.openingMessage,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<ConversationMessage> generateReply({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
    required List<ConversationMessage> history,
    required String userMessage,
  }) async {
    await Future<void>.delayed(latency);
    final replies = profile.replyBank;
    final text = replies.isEmpty
        ? 'Thanks for sharing. What would you like to practice next?'
        : replies[_replyIndex % replies.length];
    _replyIndex += 1;

    return ConversationMessage(
      id: 'ai-${DateTime.now().microsecondsSinceEpoch}',
      sender: MessageSender.ai,
      text: text,
      createdAt: DateTime.now(),
    );
  }
}
