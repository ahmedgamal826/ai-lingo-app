import '../models/complaint_models.dart';

enum ComplaintDetailsStatus {
  initial,
  loading,
  ready,
  submitting,
  submitSuccess,
  error,
}

class ComplaintDetailsState {
  const ComplaintDetailsState({
    required this.status,
    required this.replyText,
    required this.selectedStatus,
    this.complaint,
    this.errorMessage,
    this.infoMessage,
  });

  factory ComplaintDetailsState.initial() {
    return const ComplaintDetailsState(
      status: ComplaintDetailsStatus.initial,
      replyText: '',
      selectedStatus: ComplaintStatus.pending,
    );
  }

  final ComplaintDetailsStatus status;
  final ComplaintItem? complaint;
  final String replyText;
  final ComplaintStatus selectedStatus;
  final String? errorMessage;
  final String? infoMessage;

  bool get isLoading =>
      status == ComplaintDetailsStatus.loading ||
      status == ComplaintDetailsStatus.initial;

  bool get isSubmitting => status == ComplaintDetailsStatus.submitting;

  bool get canSubmit =>
      !isSubmitting &&
      complaint != null &&
      replyText.trim().isNotEmpty &&
      status != ComplaintDetailsStatus.loading;

  String get submitLabel {
    if (selectedStatus == ComplaintStatus.resolved) {
      return 'Send Reply & Resolve';
    }
    return 'Send Reply & Update Status';
  }

  String replySectionTitle(String firstName) => 'Reply to $firstName';

  String helperText(String firstName) =>
      'Your reply will appear in $firstName\'s request history and notifications.';

  ComplaintDetailsState copyWith({
    ComplaintDetailsStatus? status,
    ComplaintItem? complaint,
    bool clearComplaint = false,
    String? replyText,
    ComplaintStatus? selectedStatus,
    String? errorMessage,
    bool clearError = false,
    String? infoMessage,
    bool clearInfo = false,
  }) {
    return ComplaintDetailsState(
      status: status ?? this.status,
      complaint: clearComplaint ? null : (complaint ?? this.complaint),
      replyText: replyText ?? this.replyText,
      selectedStatus: selectedStatus ?? this.selectedStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      infoMessage: clearInfo ? null : (infoMessage ?? this.infoMessage),
    );
  }
}
