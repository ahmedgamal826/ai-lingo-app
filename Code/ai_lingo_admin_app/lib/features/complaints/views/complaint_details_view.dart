import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_loading.dart';
import '../models/complaint_models.dart';
import '../viewmodels/complaint_details_cubit.dart';
import '../viewmodels/complaint_details_state.dart';
import '../widgets/complaint_status_badge.dart';
import 'complaint_reply_success_view.dart';

/// Admin Complaint Details & Reply screen (Figma node 6:79531).
class ComplaintDetailsView extends StatelessWidget {
  const ComplaintDetailsView({
    super.key,
    required this.complaintId,
    this.initialComplaint,
  });

  final String complaintId;
  final ComplaintItem? initialComplaint;

  static Future<bool?> open(
    BuildContext context, {
    required ComplaintItem complaint,
  }) {
    return Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => ComplaintDetailsView(
          complaintId: complaint.id,
          initialComplaint: complaint,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ComplaintDetailsCubit(
        complaintId: complaintId,
        initialComplaint: initialComplaint,
      ),
      child: const _ComplaintDetailsBody(),
    );
  }
}

class _ComplaintDetailsBody extends StatefulWidget {
  const _ComplaintDetailsBody();

  @override
  State<_ComplaintDetailsBody> createState() => _ComplaintDetailsBodyState();
}

class _ComplaintDetailsBodyState extends State<_ComplaintDetailsBody> {
  late final TextEditingController _replyController;
  bool _syncingReply = false;

  @override
  void initState() {
    super.initState();
    _replyController = TextEditingController();
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _syncReplyController(String value) {
    if (_replyController.text == value) return;
    _syncingReply = true;
    _replyController.value = TextEditingValue(
      text: value,
      selection: TextSelection.collapsed(offset: value.length),
    );
    _syncingReply = false;
  }

  Future<void> _onRelatedResourceTap(
    BuildContext context,
    ComplaintRelatedResource resource,
  ) async {
    // No Admin destination exists yet for weekly-test results.
    // Keep the control non-navigating until a real route is available.
    if (!resource.canOpen) return;
  }

  Future<void> _pickStatus(
    BuildContext context,
    ComplaintDetailsState state,
  ) async {
    final selected = await showModalBottomSheet<ComplaintStatus>(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 12, 8, 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (final status in ComplaintStatus.values)
                  ListTile(
                    title: Text(status.statusLabel),
                    trailing: status == state.selectedStatus
                        ? const Icon(Icons.check, color: AppColors.primary)
                        : null,
                    onTap: () => Navigator.pop(sheetContext, status),
                  ),
              ],
            ),
          ),
        );
      },
    );

    if (selected != null && context.mounted) {
      context.read<ComplaintDetailsCubit>().selectStatus(selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComplaintDetailsCubit, ComplaintDetailsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage ||
          previous.status != current.status ||
          previous.replyText != current.replyText,
      listener: (context, state) {
        _syncReplyController(state.replyText);

        if (state.errorMessage != null) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(content: Text(state.errorMessage!)));
          context.read<ComplaintDetailsCubit>().clearFeedback();
          return;
        }

        if (state.status == ComplaintDetailsStatus.submitSuccess &&
            state.complaint != null) {
          ComplaintReplySuccessView.open(context, complaint: state.complaint!);
        }
      },
      builder: (context, state) {
        final cubit = context.read<ComplaintDetailsCubit>();
        final complaint = state.complaint;

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          body: SafeArea(
            child: Column(
              children: [
                _DetailsHeader(
                  title: complaint?.requestTitle ?? 'Request',
                  onBack: () => Navigator.of(context).pop(false),
                ),
                Expanded(
                  child: state.isLoading && complaint == null
                      ? const Center(child: CustomLoading())
                      : complaint == null
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(24),
                            child: Text(
                              state.errorMessage ??
                                  AppStrings.complaintDetailsMissing,
                              style: AppTextStyles.detailsHelper,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : GestureDetector(
                          onTap: () => FocusScope.of(context).unfocus(),
                          child: SingleChildScrollView(
                            padding: const EdgeInsets.fromLTRB(20, 8, 20, 24),
                            keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior.onDrag,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _LearnerRow(complaint: complaint),
                                const SizedBox(height: 18),
                                Text(
                                  complaint.title,
                                  style: AppTextStyles.detailsComplaintTitle,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  complaint.detailsMetaLabel,
                                  style: AppTextStyles.detailsMeta,
                                ),
                                const SizedBox(height: 16),
                                _MessageCard(
                                  message: complaint.message,
                                  relatedResource: complaint.relatedResource,
                                  onRelatedTap:
                                      complaint.relatedResource == null
                                      ? null
                                      : () => _onRelatedResourceTap(
                                          context,
                                          complaint.relatedResource!,
                                        ),
                                ),
                                const SizedBox(height: 22),
                                Text(
                                  state.replySectionTitle(complaint.firstName),
                                  style: AppTextStyles.detailsSectionTitle,
                                ),
                                const SizedBox(height: 10),
                                _ReplyField(
                                  controller: _replyController,
                                  enabled: !state.isSubmitting,
                                  onChanged: (value) {
                                    if (_syncingReply) return;
                                    cubit.updateReply(value);
                                  },
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  AppStrings.complaintDetailsUpdateStatus,
                                  style: AppTextStyles.detailsSectionTitle,
                                ),
                                const SizedBox(height: 10),
                                _StatusDropdown(
                                  label: state.selectedStatus.statusLabel,
                                  enabled: !state.isSubmitting,
                                  onTap: () => _pickStatus(context, state),
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  state.helperText(complaint.firstName),
                                  style: AppTextStyles.detailsHelper,
                                ),
                                const SizedBox(height: 18),
                                _SubmitButton(
                                  label: state.submitLabel,
                                  enabled: state.canSubmit,
                                  loading: state.isSubmitting,
                                  onPressed: cubit.submit,
                                ),
                              ],
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension on ComplaintStatus {
  String get statusLabel {
    switch (this) {
      case ComplaintStatus.pending:
        return 'Pending';
      case ComplaintStatus.inProgress:
        return 'In Progress';
      case ComplaintStatus.resolved:
        return 'Resolved';
    }
  }
}

class _DetailsHeader extends StatelessWidget {
  const _DetailsHeader({required this.title, required this.onBack});

  final String title;
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
                title,
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

class _LearnerRow extends StatelessWidget {
  const _LearnerRow({required this.complaint});

  final ComplaintItem complaint;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.white, width: 2),
          ),
          child: Text(complaint.initials, style: AppTextStyles.avatarInitials),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                complaint.learnerName,
                style: AppTextStyles.detailsLearnerName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 2),
              Text(
                complaint.learnerEmail,
                style: AppTextStyles.detailsLearnerEmail,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        ComplaintStatusBadge(status: complaint.status),
      ],
    );
  }
}

class _MessageCard extends StatelessWidget {
  const _MessageCard({
    required this.message,
    required this.relatedResource,
    this.onRelatedTap,
  });

  final String message;
  final ComplaintRelatedResource? relatedResource;
  final VoidCallback? onRelatedTap;

  @override
  Widget build(BuildContext context) {
    final resource = relatedResource;
    final canOpen = resource?.canOpen == true && onRelatedTap != null;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EAF2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(message, style: AppTextStyles.detailsMessage),
          if (resource != null && canOpen) ...[
            const SizedBox(height: 14),
            InkWell(
              onTap: onRelatedTap,
              borderRadius: BorderRadius.circular(8),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        resource.displayLabel,
                        style: AppTextStyles.detailsLink,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      AppAssets.externalLink,
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ReplyField extends StatelessWidget {
  const _ReplyField({
    required this.controller,
    required this.enabled,
    required this.onChanged,
  });

  final TextEditingController controller;
  final bool enabled;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minHeight: 140),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8EAF2)),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        onChanged: onChanged,
        maxLines: null,
        minLines: 6,
        keyboardType: TextInputType.multiline,
        textInputAction: TextInputAction.newline,
        style: AppTextStyles.detailsInput,
        decoration: InputDecoration(
          hintText: AppStrings.complaintDetailsReplyHint,
          hintStyle: AppTextStyles.detailsInput.copyWith(
            color: AppColors.textSecondary,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(16),
        ),
      ),
    );
  }
}

class _StatusDropdown extends StatelessWidget {
  const _StatusDropdown({
    required this.label,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        onTap: enabled ? onTap : null,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          height: 52,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFE8EAF2)),
          ),
          child: Row(
            children: [
              Expanded(child: Text(label, style: AppTextStyles.detailsInput)),
              SvgPicture.asset(
                AppAssets.chevronDown,
                width: 18,
                height: 18,
                colorFilter: const ColorFilter.mode(
                  AppColors.textSecondary,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton({
    required this.label,
    required this.enabled,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool enabled;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 52,
      child: ElevatedButton(
        onPressed: enabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.45),
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.white.withValues(alpha: 0.85),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.4,
                  valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.send,
                    width: 18,
                    height: 18,
                    colorFilter: const ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                  const SizedBox(width: AppDimensions.spaceSm),
                  Text(label, style: AppTextStyles.detailsButton),
                ],
              ),
      ),
    );
  }
}
