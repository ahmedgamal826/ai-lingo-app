import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../models/scenario_models.dart';

class ScenariosState {
  const ScenariosState({
    required this.selectedTab,
    required this.levelBadge,
    required this.scenarios,
    this.selectedNavIndex = 1,
  });

  factory ScenariosState.initial() {
    return const ScenariosState(
      selectedTab: PracticeTab.scenarios,
      levelBadge: AppStrings.levelBadgeB1,
      selectedNavIndex: 1,
      scenarios: [
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
  final int selectedNavIndex;

  bool get isScenariosTab => selectedTab == PracticeTab.scenarios;

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
    int? selectedNavIndex,
  }) {
    return ScenariosState(
      selectedTab: selectedTab ?? this.selectedTab,
      levelBadge: levelBadge ?? this.levelBadge,
      scenarios: scenarios ?? this.scenarios,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
    );
  }
}
