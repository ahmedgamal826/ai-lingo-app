import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_state.dart';

/// ViewModel for the Home feature.
///
/// Coordinates presentation state. Feature services will be injected here
/// when home needs remote or local data.
class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState.initial());
}
