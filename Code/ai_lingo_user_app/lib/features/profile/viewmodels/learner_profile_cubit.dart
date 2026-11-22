import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/learner_profile_model.dart';
import 'learner_profile_state.dart';

class LearnerProfileCubit extends Cubit<LearnerProfileState> {
  LearnerProfileCubit() : super(const LearnerProfileState());

  void updateName(String value) => _updateProfile(fullName: value);
  void updateEmail(String value) => _updateProfile(email: value);
  void updateUniversity(String value) => _updateProfile(university: value);
  void updateLanguage(String value) => _updateProfile(language: value);
  void updateStudyGoal(String value) => _updateProfile(studyGoal: value);
  void updateDailyGoal(String value) => _updateProfile(dailyGoal: value);

  void _updateProfile({
    String? fullName, String? email, String? university,
    String? language, String? studyGoal, String? dailyGoal,
  }) {
    emit(state.copyWith(profile: state.profile.copyWith(
      fullName: fullName, email: email, university: university,
      language: language, studyGoal: studyGoal, dailyGoal: dailyGoal,
    )));
  }

  void toggleTopic(String topic) {
    final topics = [...state.profile.topics];
    topics.contains(topic) ? topics.remove(topic) : topics.add(topic);
    _updateProfileTopics(topics);
  }

  void _updateProfileTopics(List<String> topics) {
    emit(state.copyWith(profile: state.profile.copyWith(topics: topics)));
  }

  void toggleNotifications(bool value) =>
      emit(state.copyWith(profile: state.profile.copyWith(notificationsEnabled: value)));
  void toggleWeeklyReport(bool value) =>
      emit(state.copyWith(profile: state.profile.copyWith(weeklyReportEnabled: value)));
  void toggleEmailUpdates(bool value) =>
      emit(state.copyWith(profile: state.profile.copyWith(emailUpdatesEnabled: value)));

  void saveProfile() => emit(state.copyWith(message: 'Profile changes saved successfully.'));
  void setComplaintTitle(String value) => emit(state.copyWith(complaintTitle: value));
  void setComplaintCategory(String value) => emit(state.copyWith(complaintCategory: value));
  void setComplaintDescription(String value) => emit(state.copyWith(complaintDescription: value));

  void submitComplaint() {
    if (state.complaintTitle.trim().isEmpty || state.complaintDescription.trim().isEmpty) {
      emit(state.copyWith(complaintSubmitted: false, message: 'Please complete the title and description.'));
      return;
    }
    emit(state.copyWith(complaintSubmitted: true, message: 'Complaint submitted.'));
  }

  void markNotificationsRead() => emit(state.copyWith(notificationsRead: true));
  void clearMessage() => emit(state.copyWith(clearMessage: true));
  void logout() => emit(state.copyWith(message: 'You have been logged out.'));
}
