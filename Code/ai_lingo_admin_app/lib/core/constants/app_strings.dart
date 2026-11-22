/// Centralized admin-facing copy.
class AppStrings {
  AppStrings._();

  static const String appName = 'AI Lingo Admin';
  static const String appTagline = 'Manage AI Lingo content';

  static const String retry = 'Retry';
  static const String cancel = 'Cancel';
  static const String confirm = 'Confirm';
  static const String loading = 'Loading...';
  static const String somethingWentWrong = 'Something went wrong';
  static const String noData = 'Nothing to show yet';

  // Bottom navigation
  static const String navDashboard = 'Dashboard';
  static const String navQuizzes = 'Quizzes';
  static const String navComplaints = 'Complaints';
  static const String navNotifications = 'Notifications';
  static const String navProfile = 'Profile';

  // Complaints
  static const String complaintsTitle = 'Complaints';
  static const String complaintsSubtitle = 'HELP LEARNERS MOVE FORWARD';
  static const String complaintsTabAll = 'All';
  static const String complaintsTabPending = 'Pending';
  static const String complaintsTabResolved = 'Resolved';
  static const String complaintsSearchHint = 'Search by name, title, or ID';
  static const String complaintsEmpty = 'No complaints match your filters.';
  static const String complaintsLoadMore = 'Load more';
  static const String complaintsFilterTitle = 'Filter & sort';
  static const String complaintsCategoryAll = 'All categories';
  static const String complaintsSortNewest = 'Newest first';
  static const String complaintsSortOldest = 'Oldest first';
  static const String complaintsApply = 'Apply';
  static const String complaintsClearSearch = 'Clear';

  // Complaint details
  static const String complaintDetailsUpdateStatus = 'Update status';
  static const String complaintDetailsReplyHint =
      'Write your reply to the learner…';
  static const String complaintDetailsSendResolve = 'Send Reply & Resolve';
  static const String complaintDetailsSendUpdate = 'Send Reply & Update Status';
  static const String complaintDetailsMissing =
      'This complaint could not be found.';
  static const String complaintDetailsResourceUnavailable =
      'This related result is not available in Admin yet.';

  // Complaint reply success
  static const String complaintReplySentTitle = 'Reply sent';
  static const String complaintReplySentHeading = 'One less roadblock.';
  static const String complaintReplySentCardTitle = 'All set';
  static const String complaintReplySentBack = 'Back to Complaints';
}
