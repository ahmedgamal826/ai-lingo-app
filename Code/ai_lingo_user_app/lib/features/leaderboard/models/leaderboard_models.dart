enum LeaderboardPeriod { weekly, overall }

class LeaderboardEntry {
  const LeaderboardEntry({
    required this.rank,
    required this.initials,
    required this.name,
    required this.quizCount,
    required this.points,
    this.isCurrentUser = false,
  });

  final int rank;
  final String initials;
  final String name;
  final int quizCount;
  final int points;
  final bool isCurrentUser;

  String get pointsLabel {
    final raw = points.toString();
    final buffer = StringBuffer();
    for (var i = 0; i < raw.length; i++) {
      final remaining = raw.length - i;
      if (i > 0 && remaining % 3 == 0) buffer.write(',');
      buffer.write(raw[i]);
    }
    return buffer.toString();
  }

  String get podiumPointsLabel => '$pointsLabel pts';

  String get quizBadgeLabel => '$quizCount quiz';
}
