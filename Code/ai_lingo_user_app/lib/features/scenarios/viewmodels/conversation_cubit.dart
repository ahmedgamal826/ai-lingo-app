import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/scenario_conversation_profiles.dart';
import '../models/conversation_models.dart';
import '../models/scenario_models.dart';
import '../services/conversation_ai_service.dart';
import '../services/conversation_evaluation_service.dart';
import '../services/mock_conversation_ai_service.dart';
import '../services/mock_conversation_evaluation_service.dart';
import 'conversation_state.dart';

/// ViewModel for an AI Conversation practice session.
class ConversationCubit extends Cubit<ConversationState> {
  factory ConversationCubit({
    required ScenarioItem scenario,
    String? levelLabel,
    ConversationAiService? aiService,
    ConversationEvaluationService? evaluationService,
  }) {
    final resolvedAi = aiService ?? MockConversationAiService();
    final resolvedEvaluation =
        evaluationService ?? MockConversationEvaluationService();
    final profile = ScenarioConversationProfiles.forScenario(scenario);
    final cubit = ConversationCubit._(
      scenario: scenario,
      profile: profile,
      levelLabel: levelLabel ?? profile.levelLabel,
      aiService: resolvedAi,
      evaluationService: resolvedEvaluation,
    );
    cubit._bootstrap();
    return cubit;
  }

  ConversationCubit._({
    required ScenarioItem scenario,
    required ScenarioConversationProfile profile,
    required String levelLabel,
    required this._aiService,
    required this._evaluationService,
  }) : super(
         ConversationState.initial(
           scenario: scenario,
           profile: profile,
           levelLabel: levelLabel,
           partnerAvailability: _aiService.availability,
         ),
       );

  final ConversationAiService _aiService;
  final ConversationEvaluationService _evaluationService;
  bool _isEvaluating = false;

  Future<void> _bootstrap() async {
    emit(
      state.copyWith(
        status: ConversationStatus.active,
        isAiTyping: true,
        clearError: true,
      ),
    );
    try {
      final opening = await _aiService.createOpeningMessage(
        scenario: state.scenario,
        profile: state.profile,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          messages: [opening],
          isAiTyping: false,
          status: ConversationStatus.active,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isAiTyping: false,
          status: ConversationStatus.error,
          errorMessage: 'Could not start the conversation. Please try again.',
        ),
      );
    }
  }

  Future<void> sendMessage(String rawText) async {
    final text = rawText.trim();
    if (text.isEmpty || !state.canSend) return;

    final userMessage = ConversationMessage(
      id: 'user-${DateTime.now().microsecondsSinceEpoch}',
      sender: MessageSender.user,
      text: text,
      createdAt: DateTime.now(),
    );

    final history = [...state.messages, userMessage];
    emit(
      state.copyWith(
        messages: history,
        isSending: true,
        isAiTyping: true,
        clearError: true,
        status: ConversationStatus.active,
        currentHintIndex: state.currentHintIndex + 1,
      ),
    );

    try {
      final reply = await _aiService.generateReply(
        scenario: state.scenario,
        profile: state.profile,
        history: history,
        userMessage: text,
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          messages: [...history, reply],
          isSending: false,
          isAiTyping: false,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          isSending: false,
          isAiTyping: false,
          status: ConversationStatus.error,
          errorMessage: 'Failed to get a reply. Your message was kept.',
        ),
      );
    }
  }

  Future<ConversationEvaluation?> endAndEvaluate() async {
    if (!state.canEvaluate || _isEvaluating) return null;
    _isEvaluating = true;
    emit(
      state.copyWith(status: ConversationStatus.evaluating, clearError: true),
    );

    try {
      final result = await _evaluationService.evaluate(
        scenario: state.scenario,
        profile: state.profile,
        levelLabel: state.levelLabel,
        messages: state.messages,
      );
      if (isClosed) return null;
      emit(
        state.copyWith(
          status: ConversationStatus.evaluated,
          evaluation: result,
        ),
      );
      return result;
    } catch (_) {
      if (isClosed) return null;
      emit(
        state.copyWith(
          status: ConversationStatus.active,
          errorMessage: 'Evaluation failed. You can try End & evaluate again.',
        ),
      );
      return null;
    } finally {
      _isEvaluating = false;
    }
  }

  void clearError() {
    if (state.errorMessage == null) return;
    emit(state.copyWith(clearError: true, status: ConversationStatus.active));
  }
}
