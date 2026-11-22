import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/conversation_models.dart';
import 'conversation_evaluation_state.dart';

/// ViewModel for Conversation Evaluation results.
class ConversationEvaluationCubit extends Cubit<ConversationEvaluationState> {
  ConversationEvaluationCubit(ConversationEvaluation evaluation)
    : super(ConversationEvaluationState(evaluation: evaluation));
}
