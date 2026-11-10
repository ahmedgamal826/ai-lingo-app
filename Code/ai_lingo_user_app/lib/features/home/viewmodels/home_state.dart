import 'package:ai_lingo_user_app/core/constants/app_strings.dart';

/// View state for the Home screen.
class HomeState {
  const HomeState({required this.title, required this.subtitle});

  factory HomeState.initial() {
    return const HomeState(
      title: AppStrings.appName,
      subtitle: AppStrings.appTagline,
    );
  }

  final String title;
  final String subtitle;

  HomeState copyWith({String? title, String? subtitle}) {
    return HomeState(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
    );
  }
}
