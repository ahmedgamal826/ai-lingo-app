import 'package:flutter/foundation.dart';

/// In-app learner progress snapshot shared by Progress and Home.
///
/// Values mirror the existing Progress UI mock data until a backend exists.
class LearnerProgressService extends ChangeNotifier {
  LearnerProgressService._();

  static final LearnerProgressService instance = LearnerProgressService._();

  int streakDays = 7;
  int minutesDone = 10;
  int minutesGoal = 15;
  int conversationsCompleted = 24;
  int wordsSaved = 128;
  int averageScorePercent = 86;
  int leaderboardRank = 12;

  int get progressPercent {
    if (minutesGoal <= 0) return 0;
    return ((minutesDone * 100) / minutesGoal).round().clamp(0, 100);
  }

  String get streakLabel => '🔥 $streakDays-day streak';

  /// Parses profile values like `30 min` into the daily minute goal.
  void applyDailyGoalLabel(String dailyGoal) {
    final match = RegExp(r'(\d+)').firstMatch(dailyGoal);
    if (match == null) return;
    final parsed = int.tryParse(match.group(1)!);
    if (parsed == null || parsed <= 0) return;
    if (minutesGoal == parsed) return;
    minutesGoal = parsed;
    notifyListeners();
  }

  void recordWordSaved() {
    wordsSaved += 1;
    notifyListeners();
  }

  void recordWordRemoved() {
    if (wordsSaved <= 0) return;
    wordsSaved -= 1;
    notifyListeners();
  }

  void recordConversationCompleted({
    required int overallScore,
    int addedMinutes = 5,
  }) {
    conversationsCompleted += 1;
    minutesDone += addedMinutes;
    averageScorePercent =
        ((averageScorePercent + overallScore.clamp(0, 100)) / 2).round();
    notifyListeners();
  }
}
