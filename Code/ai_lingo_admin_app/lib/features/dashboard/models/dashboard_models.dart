/// One statistic card (e.g. Total Users).
class DashboardStat {
  const DashboardStat({
    required this.title,
    required this.value,
    required this.iconName,
    this.caption,
  });

  final String title;
  final String value;

  /// SVG name from `assets/icons/` (e.g. 'users-round').
  final String iconName;
  final String? caption;
}

/// One row in "Recent activities".
class DashboardActivity {
  const DashboardActivity({
    required this.title,
    required this.subtitle,
    required this.iconName,
  });

  final String title;
  final String subtitle;

  /// SVG name from `assets/icons/` (e.g. 'clipboard-check').
  final String iconName;
}