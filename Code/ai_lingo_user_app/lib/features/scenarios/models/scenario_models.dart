enum PracticeTab { scenarios, weeklyTest }

class ScenarioItem {
  const ScenarioItem({
    required this.title,
    required this.description,
    required this.meta,
    required this.iconAsset,
  });

  final String title;
  final String description;
  final String meta;
  final String iconAsset;
}
