import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../data/mock_quiz_questions.dart';
import '../models/quiz_models.dart';
import '../models/quiz_result_models.dart';
import '../models/weekly_test_models.dart';

/// Single source of truth for the current weekly test window and the
/// signed-in learner's attempt.
///
/// There is no Firebase/HTTP weekly-test API in this project yet, so the
/// service owns the in-app schedule and attempt state. Status is always
/// derived from [opensAt]/[closesAt] vs the current clock.
class WeeklyTestService {
  WeeklyTestService._() {
    seedActiveWindow();
  }

  static final WeeklyTestService instance = WeeklyTestService._();

  static const String testId = 'week-46-everyday-english';
  static const int maxAttempts = 1;
  static const String levelLabel = 'B1 Intermediate';

  static const _months = <String>[
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  static const _weekdays = <String>[
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  late DateTime opensAt;
  late DateTime closesAt;
  QuizAttemptResult? currentUserAttempt;

  final QuizSessionConfig sessionConfig = MockQuizQuestions.buildSession();

  int get attemptsUsed => currentUserAttempt?.attemptNumber ?? 0;

  int get attemptsRemaining =>
      (maxAttempts - attemptsUsed).clamp(0, maxAttempts);

  bool get hasAvailableResult => currentUserAttempt != null;

  bool get canStartAttempt => attemptsRemaining > 0;

  WeeklyTestStatus statusAt(DateTime now) {
    if (now.isBefore(opensAt)) return WeeklyTestStatus.locked;
    if (now.isBefore(closesAt)) return WeeklyTestStatus.active;
    return WeeklyTestStatus.closed;
  }

  /// Builds presentation info from the live schedule + attempt.
  WeeklyTestInfo buildInfo(DateTime now) {
    final attempt = currentUserAttempt;
    final closedBody = attempt == null
        ? AppStrings.weeklyTestClosedNoResultBody
        : 'You scored ${attempt.displayScore}/${attempt.maxScore} '
            'and earned ${attempt.earnedPoints} points.';

    final closedTitle = attempt == null
        ? AppStrings.weeklyTestClosedNoResultTitle
        : AppStrings.weeklyTestClosedMessageTitle;

    return WeeklyTestInfo(
      title: AppStrings.weeklyTestTitle,
      description: AppStrings.weeklyTestDescription,
      opensAt: opensAt,
      closesAt: closesAt,
      scheduleTitle: _formatOpenTitle(opensAt),
      scheduleSubtitle: 'Closes ${_formatCloseSubtitle(closesAt)}',
      durationTitle:
          '${sessionConfig.duration.inMinutes} minutes · ${sessionConfig.questions.length} questions',
      durationSubtitle: '${sessionConfig.totalPoints} points · $levelLabel',
      attemptsAvailableLabel: attemptsRemaining == 1
          ? '1 attempt available'
          : '$attemptsRemaining attempts available',
      attemptsUsedLabel:
          '$attemptsUsed of $maxAttempts attempt${maxAttempts == 1 ? '' : 's'} used',
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
        iconAsset: attempt == null ? AppAssets.circleCheck : AppAssets.trophy,
        title: closedTitle,
        body: closedBody,
      ),
      lockedButtonLabel: 'Available ${_formatButtonWhen(opensAt)}',
      activeButtonLabel: AppStrings.weeklyTestActiveButton,
      closedButtonLabel: AppStrings.weeklyTestClosedButton,
      endedAtLabel: _formatEndedAt(closesAt),
    );
  }

  void saveAttempt(QuizAttemptResult result) {
    currentUserAttempt = result;
  }

  void seedLockedWindow({DateTime? now}) {
    final clock = now ?? DateTime.now();
    opensAt = clock.add(const Duration(days: 1, hours: 4, minutes: 15));
    closesAt = opensAt.add(const Duration(days: 2, hours: 11));
    currentUserAttempt = null;
  }

  void seedActiveWindow({DateTime? now}) {
    final clock = now ?? DateTime.now();
    opensAt = clock.subtract(const Duration(days: 1, hours: 4));
    closesAt = clock.add(const Duration(days: 2, hours: 10, minutes: 30));
    currentUserAttempt = null;
  }

  void seedClosedWindow({DateTime? now, QuizAttemptResult? attempt}) {
    final clock = now ?? DateTime.now();
    opensAt = clock.subtract(const Duration(days: 4));
    closesAt = clock.subtract(const Duration(days: 1, hours: 2));
    currentUserAttempt = attempt;
  }

  static String _formatOpenTitle(DateTime dt) {
    final weekday = _weekdays[dt.weekday - 1];
    return '$weekday, ${_months[dt.month - 1]} ${dt.day} · ${_formatTime(dt)}';
  }

  static String _formatCloseSubtitle(DateTime dt) {
    final weekday = _weekdays[dt.weekday - 1];
    return '$weekday, ${_months[dt.month - 1]} ${dt.day} · ${_formatTime(dt)}';
  }

  static String _formatButtonWhen(DateTime dt) {
    return '${_months[dt.month - 1]} ${dt.day} · ${_formatTime(dt)}';
  }

  static String _formatEndedAt(DateTime dt) {
    return '${dt.day} ${_months[dt.month - 1]} · ${_formatTime(dt)}';
  }

  static String _formatTime(DateTime dt) {
    final hour = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }
}
