import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

/// ViewModel for the Home feature.
///
/// Holds mock presentation state for the Home screen.
/// Feature services can be injected later without changing architecture.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());

  /// Updates the selected bottom-navigation tab.
  /// Other feature screens are not implemented yet, so content stays on Home.
  void selectTab(int index) {
    if (index == state.selectedNavIndex) return;
    emit(state.copyWith(selectedNavIndex: index));
  }
}
