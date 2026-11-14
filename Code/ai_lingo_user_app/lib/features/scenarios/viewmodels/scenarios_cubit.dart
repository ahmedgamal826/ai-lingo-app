import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/scenario_models.dart';
import 'scenarios_state.dart';

/// ViewModel for the Practice Scenarios feature.
class ScenariosCubit extends Cubit<ScenariosState> {
  ScenariosCubit() : super(ScenariosState.initial());

  void selectTab(PracticeTab tab) {
    if (tab == state.selectedTab) return;
    emit(state.copyWith(selectedTab: tab));
  }

  void selectNav(int index) {
    if (index == state.selectedNavIndex) return;
    emit(state.copyWith(selectedNavIndex: index));
  }
}
