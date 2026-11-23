import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/quiz_result_models.dart';
import 'weekly_quiz_results_state.dart';

/// ViewModel for the Weekly Quiz Results screen.
class WeeklyQuizResultsCubit extends Cubit<WeeklyQuizResultsState> {
  WeeklyQuizResultsCubit(QuizAttemptResult result)
    : super(WeeklyQuizResultsState(result: result));
}
