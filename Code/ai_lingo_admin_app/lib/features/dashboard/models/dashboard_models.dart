import 'package:flutter/widgets.dart';

/// One statistic card (e.g. Total Users).
class DashboardStat {
  const DashboardStat({
    required this.title,
    required this.value,
    required this.icon,
    this.caption,
  });

  final String title;
  final String value;
  final IconData icon;
  final String? caption;
}

/// One row in "Recent activities".
class DashboardActivity {
  const DashboardActivity({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}