import '../../../core/constants/app_strings.dart';
import '../models/leaderboard_models.dart';

class LeaderboardState {
  const LeaderboardState({
    required this.period,
    required this.selectedNavIndex,
    required this.weeklyTop,
    required this.weeklyRanking,
    required this.overallTop,
    required this.overallRanking,
  });

  factory LeaderboardState.initial() {
    return const LeaderboardState(
      period: LeaderboardPeriod.weekly,
      selectedNavIndex: 0,
      weeklyTop: [
        LeaderboardEntry(
          rank: 2,
          initials: 'LP',
          name: 'Liam',
          quizCount: 98,
          points: 980,
        ),
        LeaderboardEntry(
          rank: 1,
          initials: 'SR',
          name: 'Sofia',
          quizCount: 100,
          points: 1020,
        ),
        LeaderboardEntry(
          rank: 3,
          initials: 'OB',
          name: 'Olivia',
          quizCount: 96,
          points: 960,
        ),
      ],
      weeklyRanking: [
        LeaderboardEntry(
          rank: 4,
          initials: 'DK',
          name: 'Daniel Kim',
          quizCount: 94,
          points: 940,
        ),
        LeaderboardEntry(
          rank: 5,
          initials: 'EL',
          name: 'Emma Lewis',
          quizCount: 92,
          points: 920,
        ),
        LeaderboardEntry(
          rank: 11,
          initials: 'NW',
          name: 'Noah Wilson',
          quizCount: 91,
          points: 860,
        ),
        LeaderboardEntry(
          rank: 12,
          initials: 'AC',
          name: 'Alex Carter',
          quizCount: 90,
          points: 850,
          isCurrentUser: true,
        ),
        LeaderboardEntry(
          rank: 13,
          initials: 'MC',
          name: 'Mia Chen',
          quizCount: 88,
          points: 830,
        ),
      ],
      overallTop: [
        LeaderboardEntry(
          rank: 2,
          initials: 'LP',
          name: 'Liam',
          quizCount: 98,
          points: 9820,
        ),
        LeaderboardEntry(
          rank: 1,
          initials: 'SR',
          name: 'Sofia',
          quizCount: 100,
          points: 10450,
        ),
        LeaderboardEntry(
          rank: 3,
          initials: 'OB',
          name: 'Olivia',
          quizCount: 96,
          points: 9600,
        ),
      ],
      overallRanking: [
        LeaderboardEntry(
          rank: 4,
          initials: 'DK',
          name: 'Daniel Kim',
          quizCount: 94,
          points: 8250,
        ),
        LeaderboardEntry(
          rank: 5,
          initials: 'EL',
          name: 'Emma Lewis',
          quizCount: 92,
          points: 8100,
        ),
        LeaderboardEntry(
          rank: 11,
          initials: 'NW',
          name: 'Noah Wilson',
          quizCount: 89,
          points: 6450,
        ),
        LeaderboardEntry(
          rank: 12,
          initials: 'AC',
          name: 'Alex Carter',
          quizCount: 90,
          points: 6420,
          isCurrentUser: true,
        ),
        LeaderboardEntry(
          rank: 13,
          initials: 'MC',
          name: 'Mia Chen',
          quizCount: 88,
          points: 6300,
        ),
      ],
    );
  }

  final LeaderboardPeriod period;
  final int selectedNavIndex;
  final List<LeaderboardEntry> weeklyTop;
  final List<LeaderboardEntry> weeklyRanking;
  final List<LeaderboardEntry> overallTop;
  final List<LeaderboardEntry> overallRanking;

  bool get isWeekly => period == LeaderboardPeriod.weekly;

  String get podiumCaption =>
      isWeekly ? AppStrings.weeklyStarsLabel : AppStrings.overallStarsLabel;

  List<LeaderboardEntry> get topLearners => isWeekly ? weeklyTop : overallTop;

  List<LeaderboardEntry> get ranking =>
      isWeekly ? weeklyRanking : overallRanking;

  LeaderboardState copyWith({
    LeaderboardPeriod? period,
    int? selectedNavIndex,
    List<LeaderboardEntry>? weeklyTop,
    List<LeaderboardEntry>? weeklyRanking,
    List<LeaderboardEntry>? overallTop,
    List<LeaderboardEntry>? overallRanking,
  }) {
    return LeaderboardState(
      period: period ?? this.period,
      selectedNavIndex: selectedNavIndex ?? this.selectedNavIndex,
      weeklyTop: weeklyTop ?? this.weeklyTop,
      weeklyRanking: weeklyRanking ?? this.weeklyRanking,
      overallTop: overallTop ?? this.overallTop,
      overallRanking: overallRanking ?? this.overallRanking,
    );
  }
}
