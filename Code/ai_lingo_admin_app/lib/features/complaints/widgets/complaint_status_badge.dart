import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/complaint_models.dart';

class ComplaintStatusBadge extends StatelessWidget {
  const ComplaintStatusBadge({super.key, required this.status});

  final ComplaintStatus status;

  @override
  Widget build(BuildContext context) {
    final Color background;
    final TextStyle style;
    switch (status) {
      case ComplaintStatus.pending:
        background = AppColors.warningLight;
        style = AppTextStyles.statusPending;
      case ComplaintStatus.inProgress:
        background = AppColors.primaryLight;
        style = AppTextStyles.statusInProgress;
      case ComplaintStatus.resolved:
        background = AppColors.successLight;
        style = AppTextStyles.statusResolved;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status == ComplaintStatus.pending
            ? 'Pending'
            : status == ComplaintStatus.inProgress
            ? 'In Progress'
            : 'Resolved',
        style: style,
      ),
    );
  }
}
