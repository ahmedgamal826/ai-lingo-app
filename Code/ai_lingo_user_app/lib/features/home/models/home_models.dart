/// Lightweight presentation models for Home mock data.
class ScenarioSuggestion {
  const ScenarioSuggestion({
    required this.title,
    required this.meta,
    required this.iconAsset,
  });

  final String title;
  final String meta;
  final String iconAsset;
}

class SavedWordPreview {
  const SavedWordPreview({required this.word, required this.definition});

  final String word;
  final String definition;
}

class LearningStat {
  const LearningStat({required this.value, required this.label});

  final String value;
  final String label;
}
