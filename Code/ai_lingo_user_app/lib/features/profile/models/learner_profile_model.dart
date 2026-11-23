class LearnerProfileModel {
  const LearnerProfileModel({
    this.fullName = 'Alex Carter',
    this.email = 'alex.carter@gmail.com',
    this.university = 'University of Technology',
    this.avatarInitials = 'AC',
    this.level = 'Intermediate',
    this.dailyReminderEnabled = true,
    this.dailyReminderTime = '08:00 AM',
    this.language = 'English',
    this.studyGoal = 'Improve my skills',
    this.dailyGoal = '30 min',
    this.topics = const ['Technology', 'Business', 'Science'],
    this.notificationsEnabled = true,
    this.weeklyReportEnabled = true,
    this.emailUpdatesEnabled = false,
  });

  final String fullName;
  final String email;
  final String university;
  final String avatarInitials;
  final String level;
  final bool dailyReminderEnabled;
  final String dailyReminderTime;
  final String language;
  final String studyGoal;
  final String dailyGoal;
  final List<String> topics;
  final bool notificationsEnabled;
  final bool weeklyReportEnabled;
  final bool emailUpdatesEnabled;

  LearnerProfileModel copyWith({
    String? fullName,
    String? email,
    String? university,
    String? avatarInitials,
    String? level,
    bool? dailyReminderEnabled,
    String? dailyReminderTime,
    String? language,
    String? studyGoal,
    String? dailyGoal,
    List<String>? topics,
    bool? notificationsEnabled,
    bool? weeklyReportEnabled,
    bool? emailUpdatesEnabled,
  }) => LearnerProfileModel(
    fullName: fullName ?? this.fullName,
    email: email ?? this.email,
    university: university ?? this.university,
    avatarInitials: avatarInitials ?? this.avatarInitials,
    level: level ?? this.level,
    dailyReminderEnabled: dailyReminderEnabled ?? this.dailyReminderEnabled,
    dailyReminderTime: dailyReminderTime ?? this.dailyReminderTime,
    language: language ?? this.language,
    studyGoal: studyGoal ?? this.studyGoal,
    dailyGoal: dailyGoal ?? this.dailyGoal,
    topics: topics ?? this.topics,
    notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
    weeklyReportEnabled: weeklyReportEnabled ?? this.weeklyReportEnabled,
    emailUpdatesEnabled: emailUpdatesEnabled ?? this.emailUpdatesEnabled,
  );
}

class ComplaintModel {
  const ComplaintModel({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.status,
    required this.date,
    this.reply,
  });
  final String id, title, category, description, status, date;
  final String? reply;
}
