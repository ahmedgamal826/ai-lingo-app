import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../data/mock_quiz_result.dart';
import '../models/quiz_result_models.dart';
import '../models/scenario_models.dart';
import '../models/weekly_test_models.dart';
import 'scenarios_state.dart';

/// ViewModel for the Practice Scenarios / Weekly Test feature.
class ScenariosCubit extends Cubit<ScenariosState> {
  ScenariosCubit() : super(ScenariosState.initial()) {
    _startTicker();
  }

  Timer? _ticker;
  bool _isStartingQuiz = false;
  bool _isOpeningResults = false;

  void selectTab(PracticeTab tab) {
    if (tab == state.selectedTab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  void selectNav(int index) {
    if (index == state.selectedNavIndex) return;
    emit(state.copyWith(selectedNavIndex: index));
  }

  bool get canStartWeeklyTest =>
      !_isStartingQuiz && state.weeklyTestStatus == WeeklyTestStatus.active;

  bool beginWeeklyTestSession() {
    if (!canStartWeeklyTest) return false;
    _isStartingQuiz = true;
    return true;
  }

  void clearWeeklyTestStartLock() {
    _isStartingQuiz = false;
  }

  bool get canOpenWeeklyResults =>
      !_isOpeningResults &&
      state.weeklyTestStatus == WeeklyTestStatus.closed &&
      resolveAttemptResult() != null;

  bool beginWeeklyResultsSession() {
    if (!canOpenWeeklyResults) return false;
    _isOpeningResults = true;
    return true;
  }

  void clearWeeklyResultsOpenLock() {
    _isOpeningResults = false;
  }

  /// Prefers the real completed attempt; falls back to scored demo data.
  QuizAttemptResult? resolveAttemptResult() {
    if (state.latestAttempt != null) return state.latestAttempt;
    if (state.weeklyTestStatus != WeeklyTestStatus.closed) return null;
    return MockQuizResult.buildDemo();
  }

  void saveAttemptResult(QuizAttemptResult result) {
    final closedBody =
        'You scored ${result.displayScore}/${result.maxScore} '
        'and earned ${result.earnedPoints} points.';
    emit(
      state.copyWith(
        latestAttempt: result,
        weeklyTest: state.weeklyTest.copyWith(
          closedMessage: WeeklyTestMessage(
            iconAsset: AppAssets.trophy,
            title: AppStrings.weeklyTestClosedMessageTitle,
            body: closedBody,
          ),
          closesAt: DateTime.now().subtract(const Duration(seconds: 1)),
        ),
      ),
    );
  }

  void _startTicker() {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (isClosed) return;
      emit(state.copyWith(now: DateTime.now()));
    });
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    return super.close();
  }
}
