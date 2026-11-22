enum ComplaintStatus { pending, inProgress, resolved }

enum ComplaintStatusTab { all, pending, resolved }

enum ComplaintSort { newestFirst, oldestFirst }

/// Optional linked resource shown under the original message.
class ComplaintRelatedResource {
  const ComplaintRelatedResource({
    required this.label,
    this.scoreLabel,
    this.canOpen = false,
  });

  final String label;
  final String? scoreLabel;
  final bool canOpen;

  String get displayLabel {
    if (scoreLabel == null || scoreLabel!.isEmpty) return label;
    return '$label · $scoreLabel';
  }
}

class ComplaintItem {
  const ComplaintItem({
    required this.id,
    required this.learnerName,
    required this.learnerEmail,
    required this.initials,
    required this.title,
    required this.description,
    required this.message,
    required this.status,
    required this.category,
    required this.categoryLabel,
    required this.submittedAt,
    this.relatedResource,
    this.adminReply,
  });

  final String id;
  final String learnerName;
  final String learnerEmail;
  final String initials;
  final String title;
  final String description;
  final String message;
  final ComplaintStatus status;
  final String category;
  final String categoryLabel;
  final DateTime submittedAt;
  final ComplaintRelatedResource? relatedResource;
  final String? adminReply;

  String get idLabel => '#$id';

  String get requestTitle => 'Request $idLabel';

  String get firstName {
    final parts = learnerName.trim().split(RegExp(r'\s+'));
    return parts.isEmpty ? learnerName : parts.first;
  }

  String get submittedLabel {
    const months = [
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
    final month = months[submittedAt.month - 1];
    final hour24 = submittedAt.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = submittedAt.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$month ${submittedAt.day}, $hour12:$minute $period';
  }

  String get detailsSubmittedLabel {
    const months = [
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
    final month = months[submittedAt.month - 1];
    final hour24 = submittedAt.hour;
    final hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    final minute = submittedAt.minute.toString().padLeft(2, '0');
    final period = hour24 >= 12 ? 'PM' : 'AM';
    return '$month ${submittedAt.day}, ${submittedAt.year} · $hour12:$minute $period';
  }

  String get metaLabel => '$idLabel · $submittedLabel';

  String get detailsMetaLabel => '$categoryLabel · $detailsSubmittedLabel';

  String get statusLabel {
    switch (status) {
      case ComplaintStatus.pending:
        return 'Pending';
      case ComplaintStatus.inProgress:
        return 'In Progress';
      case ComplaintStatus.resolved:
        return 'Resolved';
    }
  }

  /// Confirmation body shown after a successful reply submission.
  String get replySentSummary {
    final statusPhrase = switch (status) {
      ComplaintStatus.resolved => 'is now resolved',
      ComplaintStatus.inProgress => 'is now In Progress',
      ComplaintStatus.pending => 'is now Pending',
    };
    return 'Your reply was sent to $learnerName. Request $idLabel $statusPhrase.';
  }

  /// Accurate history copy without claiming notification delivery.
  String get replySentHistoryNote =>
      '$firstName can see your response in their complaint history.';

  ComplaintItem copyWith({
    String? id,
    String? learnerName,
    String? learnerEmail,
    String? initials,
    String? title,
    String? description,
    String? message,
    ComplaintStatus? status,
    String? category,
    String? categoryLabel,
    DateTime? submittedAt,
    ComplaintRelatedResource? relatedResource,
    String? adminReply,
    bool clearAdminReply = false,
  }) {
    return ComplaintItem(
      id: id ?? this.id,
      learnerName: learnerName ?? this.learnerName,
      learnerEmail: learnerEmail ?? this.learnerEmail,
      initials: initials ?? this.initials,
      title: title ?? this.title,
      description: description ?? this.description,
      message: message ?? this.message,
      status: status ?? this.status,
      category: category ?? this.category,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      submittedAt: submittedAt ?? this.submittedAt,
      relatedResource: relatedResource ?? this.relatedResource,
      adminReply: clearAdminReply ? null : (adminReply ?? this.adminReply),
    );
  }
}

class ComplaintReplyRequest {
  const ComplaintReplyRequest({
    required this.complaintId,
    required this.reply,
    required this.status,
  });

  final String complaintId;
  final String reply;
  final ComplaintStatus status;
}

class ComplaintsPage {
  const ComplaintsPage({
    required this.items,
    required this.filteredTotal,
    required this.allCount,
    required this.pendingCount,
    required this.resolvedCount,
    required this.hasMore,
  });

  final List<ComplaintItem> items;
  final int filteredTotal;
  final int allCount;
  final int pendingCount;
  final int resolvedCount;
  final bool hasMore;
}

class ComplaintsQuery {
  const ComplaintsQuery({
    required this.statusTab,
    required this.category,
    required this.sort,
    required this.searchQuery,
    required this.offset,
    required this.limit,
  });

  final ComplaintStatusTab statusTab;
  final String? category;
  final ComplaintSort sort;
  final String searchQuery;
  final int offset;
  final int limit;
}
