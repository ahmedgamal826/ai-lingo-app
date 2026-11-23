import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/leaderboard_models.dart';
import 'leaderboard_state.dart';

/// ViewModel for the Leaderboard feature.
class LeaderboardCubit extends Cubit<LeaderboardState> {
  LeaderboardCubit() : super(LeaderboardState.initial());

  void selectPeriod(LeaderboardPeriod period) {
    if (period == state.period) return;
    emit(state.copyWith(period: period));
  }

  void selectTab(int index) {
    if (index == state.selectedNavIndex) return;
    emit(state.copyWith(selectedNavIndex: index));
  }
}
