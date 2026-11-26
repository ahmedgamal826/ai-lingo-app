class AdminProfileModel {
  const AdminProfileModel({
    this.name = 'Jamie Morgan',
    this.email = 'jamie.morgan@alingo.com',
    this.role = 'Administrator',
    this.language = 'English',
    this.newComplaints = true,
    this.userActivity = true,
    this.systemAlerts = false,
  });

  final String name;
  final String email;
  final String role;
  final String language;
  final bool newComplaints;
  final bool userActivity;
  final bool systemAlerts;

  AdminProfileModel copyWith(
          {String? name,
          String? email,
          String? role,
          String? language,
          bool? newComplaints,
          bool? userActivity,
          bool? systemAlerts}) =>
      AdminProfileModel(
          name: name ?? this.name,
          email: email ?? this.email,
          role: role ?? this.role,
          language: language ?? this.language,
          newComplaints: newComplaints ?? this.newComplaints,
          userActivity: userActivity ?? this.userActivity,
          systemAlerts: systemAlerts ?? this.systemAlerts);
}
