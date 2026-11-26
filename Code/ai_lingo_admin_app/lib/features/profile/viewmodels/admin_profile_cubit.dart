import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/admin_profile_model.dart';
import 'admin_profile_state.dart';

class AdminProfileCubit extends Cubit<AdminProfileState> {
  AdminProfileCubit() : super(const AdminProfileState());
  void updateName(String v) =>
      emit(state.copyWith(profile: state.profile.copyWith(name: v)));
  void updateEmail(String v) =>
      emit(state.copyWith(profile: state.profile.copyWith(email: v)));
  void updateLanguage(String v) =>
      emit(state.copyWith(profile: state.profile.copyWith(language: v)));
  void toggleNewComplaints(bool v) =>
      emit(state.copyWith(profile: state.profile.copyWith(newComplaints: v)));
  void toggleUserActivity(bool v) =>
      emit(state.copyWith(profile: state.profile.copyWith(userActivity: v)));
  void toggleSystemAlerts(bool v) =>
      emit(state.copyWith(profile: state.profile.copyWith(systemAlerts: v)));
  void setCurrentPassword(String v) =>
      emit(state.copyWith(currentPassword: v, passwordUpdated: false));
  void setNewPassword(String v) =>
      emit(state.copyWith(newPassword: v, passwordUpdated: false));
  void setConfirmPassword(String v) =>
      emit(state.copyWith(confirmPassword: v, passwordUpdated: false));
  void togglePasswordVisibility() =>
      emit(state.copyWith(passwordVisible: !state.passwordVisible));
  bool get passwordIsStrong =>
      state.newPassword.length >= 8 &&
      RegExp(r'[A-Z]').hasMatch(state.newPassword) &&
      RegExp(r'[a-z]').hasMatch(state.newPassword) &&
      RegExp(r'\d').hasMatch(state.newPassword) &&
      RegExp(r'[^A-Za-z0-9]').hasMatch(state.newPassword);
  bool get canUpdatePassword =>
      state.currentPassword.isNotEmpty &&
      passwordIsStrong &&
      state.newPassword == state.confirmPassword;
  void updatePassword() {
    if (canUpdatePassword) emit(state.copyWith(passwordUpdated: true));
  }

  void logout() => emit(state.copyWith(isLoggedOut: true));
}
