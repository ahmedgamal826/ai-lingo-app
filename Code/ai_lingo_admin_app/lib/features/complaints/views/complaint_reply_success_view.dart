import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/complaint_models.dart';

/// Reply sent / resolution confirmation screen (Figma node 6:79572).
class ComplaintReplySuccessView extends StatelessWidget {
  const ComplaintReplySuccessView({super.key, required this.complaint});

  final ComplaintItem complaint;

  static Future<void> open(
    BuildContext context, {
    required ComplaintItem complaint,
  }) {
    return Navigator.of(context).pushReplacement(
      MaterialPageRoute<void>(
        builder: (_) => ComplaintReplySuccessView(complaint: complaint),
      ),
      result: true,
    );
  }

  void _backToComplaints(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Column(
          children: [
            _SuccessHeader(onBack: () => _backToComplaints(context)),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight - 16,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 88,
                            height: 88,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.successLight,
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: SvgPicture.asset(
                              AppAssets.messageCheck,
                              width: 40,
                              height: 40,
                            ),
                          ),
                          const SizedBox(height: 28),
                          Text(
                            AppStrings.complaintReplySentHeading,
                            style: AppTextStyles.replySuccessHeading,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            complaint.replySentSummary,
                            style: AppTextStyles.replySuccessBody,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 28),
                          _AllSetCard(note: complaint.replySentHistoryNote),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 20),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: () => _backToComplaints(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    AppStrings.complaintReplySentBack,
                    style: AppTextStyles.detailsButton,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SuccessHeader extends StatelessWidget {
  const _SuccessHeader({required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 20, 4),
      child: SizedBox(
        height: 48,
        child: Row(
          children: [
            IconButton(
              onPressed: onBack,
              icon: SvgPicture.asset(
                AppAssets.arrowLeft,
                width: 22,
                height: 22,
              ),
            ),
            Expanded(
              child: Text(
                AppStrings.complaintReplySentTitle,
                style: AppTextStyles.detailsHeaderTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AllSetCard extends StatelessWidget {
  const _AllSetCard({required this.note});

  final String note;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 14, 16, 14),
      decoration: BoxDecoration(
        color: AppColors.successLight,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AppAssets.checkCircle, width: 24, height: 24),
          const SizedBox(width: AppDimensions.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.complaintReplySentCardTitle,
                  style: AppTextStyles.replySuccessCardTitle,
                ),
                const SizedBox(height: 4),
                Text(note, style: AppTextStyles.replySuccessCardBody),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
