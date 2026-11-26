import '../models/admin_profile_model.dart';

class AdminProfileState {
  const AdminProfileState(
      {this.profile = const AdminProfileModel(),
      this.currentPassword = '',
      this.newPassword = '',
      this.confirmPassword = '',
      this.passwordVisible = false,
      this.isLoggedOut = false,
      this.passwordUpdated = false});
  final AdminProfileModel profile;
  final String currentPassword, newPassword, confirmPassword;
  final bool passwordVisible, isLoggedOut, passwordUpdated;

  AdminProfileState copyWith(
          {AdminProfileModel? profile,
          String? currentPassword,
          String? newPassword,
          String? confirmPassword,
          bool? passwordVisible,
          bool? isLoggedOut,
          bool? passwordUpdated}) =>
      AdminProfileState(
          profile: profile ?? this.profile,
          currentPassword: currentPassword ?? this.currentPassword,
          newPassword: newPassword ?? this.newPassword,
          confirmPassword: confirmPassword ?? this.confirmPassword,
          passwordVisible: passwordVisible ?? this.passwordVisible,
          isLoggedOut: isLoggedOut ?? this.isLoggedOut,
          passwordUpdated: passwordUpdated ?? this.passwordUpdated);
}
