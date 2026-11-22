import '../models/learner_profile_model.dart';

class LearnerProfileState {
  const LearnerProfileState({
    this.profile = const LearnerProfileModel(),
    this.complaintTitle = '',
    this.complaintCategory = 'Quiz & Scoring',
    this.complaintDescription = '',
    this.complaintSubmitted = false,
    this.notificationsRead = false,
    this.isSaving = false,
    this.message,
  });

  final LearnerProfileModel profile;
  final String complaintTitle, complaintCategory, complaintDescription;
  final bool complaintSubmitted, notificationsRead, isSaving;
  final String? message;

  LearnerProfileState copyWith({
    LearnerProfileModel? profile,
    String? complaintTitle,
    String? complaintCategory,
    String? complaintDescription,
    bool? complaintSubmitted,
    bool? notificationsRead,
    bool? isSaving,
    String? message,
    bool clearMessage = false,
  }) => LearnerProfileState(
    profile: profile ?? this.profile,
    complaintTitle: complaintTitle ?? this.complaintTitle,
    complaintCategory: complaintCategory ?? this.complaintCategory,
    complaintDescription: complaintDescription ?? this.complaintDescription,
    complaintSubmitted: complaintSubmitted ?? this.complaintSubmitted,
    notificationsRead: notificationsRead ?? this.notificationsRead,
    isSaving: isSaving ?? this.isSaving,
    message: clearMessage ? null : (message ?? this.message),
  );
}
