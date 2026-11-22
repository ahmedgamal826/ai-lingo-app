import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../data/mock_quiz_result.dart';
import '../models/quiz_result_models.dart';
import '../models/scenario_models.dart';
import '../models/weekly_test_models.dart';

class ScenariosState {
  const ScenariosState({
    required this.selectedTab,
    required this.levelBadge,
    required this.scenarios,
    required this.weeklyTest,
    required this.now,
    this.selectedNavIndex = 1,
    this.latestAttempt,
  });

  /// Mock statuses: [mockStatus] selects Locked / Active / Closed window.
  factory ScenariosState.initial({
    DateTime? now,
    WeeklyTestStatus mockStatus = WeeklyTestStatus.closed,
  }) {
    final clock = now ?? DateTime.now();
    late final DateTime opensAt;
    late final DateTime closesAt;
    switch (mockStatus) {
      case WeeklyTestStatus.locked:
        opensAt = clock.add(const Duration(days: 1, hours: 4, minutes: 15));
        closesAt = opensAt.add(const Duration(days: 2, hours: 11));
      case WeeklyTestStatus.active:
        opensAt = clock.subtract(const Duration(days: 1, hours: 4));
        closesAt = clock.add(const Duration(days: 2, hours: 10, minutes: 30));
      case WeeklyTestStatus.closed:
        opensAt = clock.subtract(const Duration(days: 4));
        closesAt = clock.subtract(const Duration(days: 1, hours: 2));
    }

    final demoAttempt = mockStatus == WeeklyTestStatus.closed
        ? MockQuizResult.buildDemo()
        : null;

    final closedBody = demoAttempt == null
        ? AppStrings.weeklyTestClosedMessageBody
        : 'You scored ${demoAttempt.displayScore}/${demoAttempt.maxScore} '
              'and earned ${demoAttempt.earnedPoints} points.';

    return ScenariosState(
      selectedTab: PracticeTab.scenarios,
      levelBadge: AppStrings.levelBadgeB1,
      selectedNavIndex: 1,
      now: clock,
      latestAttempt: demoAttempt,
      weeklyTest: WeeklyTestInfo(
        title: AppStrings.weeklyTestTitle,
        description: AppStrings.weeklyTestDescription,
        opensAt: opensAt,
        closesAt: closesAt,
        scheduleTitle: AppStrings.weeklyTestScheduleTitle,
        scheduleSubtitle: AppStrings.weeklyTestScheduleSubtitle,
        durationTitle: AppStrings.weeklyTestDurationTitle,
        durationSubtitle: AppStrings.weeklyTestDurationSubtitle,
        attemptsAvailableLabel: AppStrings.weeklyTestAttemptsAvailable,
        attemptsUsedLabel: AppStrings.weeklyTestAttemptsUsed,
        lockedMessage: const WeeklyTestMessage(
          iconAsset: AppAssets.bell,
          title: AppStrings.weeklyTestLockedMessageTitle,
          body: AppStrings.weeklyTestLockedMessageBody,
        ),
        activeMessage: const WeeklyTestMessage(
          iconAsset: AppAssets.info,
          title: AppStrings.weeklyTestActiveMessageTitle,
          body: AppStrings.weeklyTestActiveMessageBody,
        ),
        closedMessage: WeeklyTestMessage(
          iconAsset: AppAssets.trophy,
          title: AppStrings.weeklyTestClosedMessageTitle,
          body: closedBody,
        ),
        lockedButtonLabel: AppStrings.weeklyTestLockedButton,
        activeButtonLabel: AppStrings.weeklyTestActiveButton,
        closedButtonLabel: AppStrings.weeklyTestClosedButton,
        endedAtLabel: AppStrings.weeklyTestEndedAt,
      ),
      scenarios: const [
        ScenarioItem(
          title: 'Restaurant',
          description: 'Order with confidence',
          meta: '8 min · Everyday',
          iconAsset: AppAssets.utensils,
        ),
        ScenarioItem(
          title: 'Job Interview',
          description: 'Make a great impression',
          meta: '12 min · Career',
          iconAsset: AppAssets.briefcaseBusiness,
        ),
        ScenarioItem(
          title: 'Travel',
          description: 'Explore without limits',
          meta: '10 min · Travel',
          iconAsset: AppAssets.plane,
        ),
        ScenarioItem(
          title: 'Shopping',
          description: 'Find just what you need',
          meta: '8 min · Everyday',
          iconAsset: AppAssets.shoppingBag,
        ),
        ScenarioItem(
          title: 'Daily Conversations',
          description: 'Small talk, big progress',
          meta: '6 min · Everyday',
          iconAsset: AppAssets.coffee,
        ),
        ScenarioItem(
          title: 'Meeting New People',
          description: 'Start a real connection',
          meta: '8 min · Social',
          iconAsset: AppAssets.usersRoundIcon,
        ),
      ],
    );
  }

  final PracticeTab selectedTab;
  final String levelBadge;
  final List<ScenarioItem> scenarios;
  final WeeklyTestInfo weeklyTest;
  final DateTime now;
  final int selectedNavIndex;
  final QuizAttemptResult? latestAttempt;

  bool get isScenariosTab => selectedTab == PracticeTab.scenarios;

  /// Completed attempt forces Closed (single-attempt weekly test).
  WeeklyTestStatus get weeklyTestStatus {
    if (latestAttempt != null) return WeeklyTestStatus.closed;
    return weeklyTest.statusAt(now);
  }

  Duration get weeklyCountdownRemaining {
    switch (weeklyTestStatus) {
      case WeeklyTestStatus.locked:
        return weeklyTest.remainingUntilOpen(now);
      case WeeklyTestStatus.active:
        return weeklyTest.remainingUntilClose(now);
      case WeeklyTestStatus.closed:
        return Duration.zero;
    }
  }

  List<List<ScenarioItem>> get scenarioRows {
    final rows = <List<ScenarioItem>>[];
    for (var i = 0; i < scenarios.length; i += 2) {
      rows.add(
        scenarios.sublist(
          i,
          i + 2 > scenarios.length ? scenarios.length : i + 2,
        ),
      );
    }
    return rows;
  }

  ScenariosState copyWith({
    PracticeTab? selectedTab,
    String? levelBadge,
    List<ScenarioItem>? scenarios,
    WeeklyTestInfo? weeklyTest,
    DateTime? now,
    int? selectedNavIndex,
    QuizAttemptResult? latestAttempt,
  }) {
    return ScenariosState(
      selectedTab: selectedTab ?? this.selectedTab,
      levelBadge: levelBadge ?? this.levelBadge,
      scenarios: scenarios ?? this.scenarios,
      weeklyTest: weeklyTest ?? this.weeklyTest,
      now: now ?? this.now,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      latestAttempt: latestAttempt ?? this.latestAttempt,
    );
  }
}
