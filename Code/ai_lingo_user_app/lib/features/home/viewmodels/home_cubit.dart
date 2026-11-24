import 'package:flutter_bloc/flutter_bloc.dart';

import '../../scenarios/models/scenario_models.dart';
import '../../scenarios/viewmodels/scenarios_state.dart';
import '../models/home_models.dart';
import 'home_state.dart';

/// ViewModel for the Home feature.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  /// Updates the selected bottom-navigation tab when Home owns its own nav.
  void selectTab(int index) {
    if (index == state.selectedNavIndex) return;
    emit(state.copyWith(selectedNavIndex: index));
  }

  /// Maps a Home suggestion card to the Practice [ScenarioItem].
  ScenarioItem? resolveScenario(ScenarioSuggestion suggestion) {
    const titleMap = <String, String>{
      'At a restaurant': 'Restaurant',
      'Job interview': 'Job Interview',
    };
    final mappedTitle = titleMap[suggestion.title];

    for (final item in ScenariosState.initial().scenarios) {
      if (item.iconAsset == suggestion.iconAsset) return item;
      if (mappedTitle != null && item.title == mappedTitle) return item;
      if (item.title == suggestion.title) return item;
    }
    return null;
  }
}
