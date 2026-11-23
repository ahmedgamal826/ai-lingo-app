import 'package:ai_lingo_user_app/core/constants/app_assets.dart';
import 'package:ai_lingo_user_app/core/constants/app_strings.dart';

import '../models/home_models.dart';

/// View state for the Home screen.
class HomeState {
  const HomeState({
    required this.userInitials,
    required this.userName,
    required this.levelLabel,
    required this.rank,
    required this.unreadCount,
    required this.streakLabel,
    required this.minutesDone,
    required this.minutesGoal,
    required this.progressPercent,
    required this.scenarios,
    required this.savedWord,
    required this.stats,
    this.selectedNavIndex = 0,
  });

  factory HomeState.initial() {
    return const HomeState(
      userInitials: 'AC',
      userName: 'Alex',
      levelLabel: 'B1 Intermediate · Keep it going!',
      rank: 12,
      unreadCount: 3,
      streakLabel: '🔥 7-day streak',
      minutesDone: 10,
      minutesGoal: 15,
      progressPercent: 67,
      selectedNavIndex: 0,
      scenarios: [
        ScenarioSuggestion(
          title: 'At a restaurant',
          meta: 'Everyday · 8 min',
          iconAsset: AppAssets.utensils,
        ),
        ScenarioSuggestion(
          title: 'Job interview',
          meta: 'Career · 12 min',
          iconAsset: AppAssets.briefcaseBusiness,
        ),
      ],
      savedWord: SavedWordPreview(
        word: 'Accommodate',
        definition: 'To provide what someone needs',
      ),
      stats: [
        LearningStat(value: '24', label: AppStrings.conversationsLabel),
        LearningStat(value: '128', label: AppStrings.wordsSavedLabel),
        LearningStat(value: '86%', label: AppStrings.avgScoreLabel),
      ],
    );
  }

  final String userInitials;
  final String userName;
  final String levelLabel;
  final int rank;
  final int unreadCount;
  final String streakLabel;
  final int minutesDone;
  final int minutesGoal;
  final int progressPercent;
  final List<ScenarioSuggestion> scenarios;
  final SavedWordPreview savedWord;
  final List<LearningStat> stats;

  /// Bottom navigation selection. `0` = Home.
  final int selectedNavIndex;

  String get greeting => 'Hey, $userName 👋';

  String get progressLabel =>
      '$minutesDone of $minutesGoal ${AppStrings.minutesTodaySuffix}';

  String get progressPercentLabel => '$progressPercent%';

  String get rankLabel => '#$rank';

  HomeState copyWith({
    String? userInitials,
    String? userName,
    String? levelLabel,
    int? rank,
    int? unreadCount,
    String? streakLabel,
    int? minutesDone,
    int? minutesGoal,
    int? progressPercent,
    List<ScenarioSuggestion>? scenarios,
    SavedWordPreview? savedWord,
    List<LearningStat>? stats,
    int? selectedNavIndex,
  }) {
    return HomeState(
      userInitials: userInitials ?? this.userInitials,
      userName: userName ?? this.userName,
      levelLabel: levelLabel ?? this.levelLabel,
      rank: rank ?? this.rank,
      unreadCount: unreadCount ?? this.unreadCount,
      streakLabel: streakLabel ?? this.streakLabel,
      minutesDone: minutesDone ?? this.minutesDone,
      minutesGoal: minutesGoal ?? this.minutesGoal,
      progressPercent: progressPercent ?? this.progressPercent,
      scenarios: scenarios ?? this.scenarios,
      savedWord: savedWord ?? this.savedWord,
      stats: stats ?? this.stats,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
    );
  }
}
