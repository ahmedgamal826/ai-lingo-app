import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/complaint_models.dart';
import '../services/complaints_service.dart';
import '../services/mock_complaints_service.dart';
import 'complaint_details_state.dart';

/// ViewModel for the Admin Complaint Details & Reply screen.
class ComplaintDetailsCubit extends Cubit<ComplaintDetailsState> {
  ComplaintDetailsCubit({
    required this.complaintId,
    this.initialComplaint,
    ComplaintsService? service,
  }) : _service = service ?? MockComplaintsService.instance,
       super(ComplaintDetailsState.initial()) {
    _load();
  }

  final String complaintId;
  final ComplaintItem? initialComplaint;
  final ComplaintsService _service;
  bool _submitLocked = false;

  Future<void> _load() async {
    final seed = initialComplaint;
    if (seed != null && seed.id == complaintId) {
      emit(
        state.copyWith(
          status: ComplaintDetailsStatus.ready,
          complaint: seed,
          replyText: seed.adminReply ?? '',
          selectedStatus: seed.status,
          clearError: true,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: ComplaintDetailsStatus.loading,
          clearError: true,
        ),
      );
    }

    try {
      final item = await _service.fetchComplaintById(complaintId);
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ComplaintDetailsStatus.ready,
          complaint: item,
          replyText: state.replyText.isNotEmpty
              ? state.replyText
              : (item.adminReply ?? ''),
          selectedStatus: state.complaint == null
              ? item.status
              : state.selectedStatus,
          clearError: true,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      if (state.complaint != null) return;
      emit(
        state.copyWith(
          status: ComplaintDetailsStatus.error,
          errorMessage: 'Could not load this complaint.',
        ),
      );
    }
  }

  void updateReply(String value) {
    emit(state.copyWith(replyText: value, clearError: true, clearInfo: true));
  }

  void selectStatus(ComplaintStatus status) {
    emit(
      state.copyWith(selectedStatus: status, clearError: true, clearInfo: true),
    );
  }

  Future<void> submit() async {
    if (_submitLocked || state.isSubmitting) return;

    final reply = state.replyText.trim();
    if (reply.isEmpty) {
      emit(
        state.copyWith(
          errorMessage: 'Please write a reply before sending.',
          clearInfo: true,
        ),
      );
      return;
    }

    if (state.complaint == null) {
      emit(
        state.copyWith(
          errorMessage: 'Complaint data is missing.',
          clearInfo: true,
        ),
      );
      return;
    }

    _submitLocked = true;
    emit(
      state.copyWith(
        status: ComplaintDetailsStatus.submitting,
        clearError: true,
        clearInfo: true,
      ),
    );

    try {
      final updated = await _service.submitReply(
        ComplaintReplyRequest(
          complaintId: complaintId,
          reply: reply,
          status: state.selectedStatus,
        ),
      );
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ComplaintDetailsStatus.submitSuccess,
          complaint: updated,
          replyText: updated.adminReply ?? reply,
          selectedStatus: updated.status,
          clearError: true,
          clearInfo: true,
        ),
      );
    } catch (_) {
      if (isClosed) return;
      _submitLocked = false;
      emit(
        state.copyWith(
          status: ComplaintDetailsStatus.ready,
          errorMessage: 'Could not send reply. Please try again.',
          clearInfo: true,
        ),
      );
    }
  }

  void clearFeedback() {
    emit(state.copyWith(clearError: true, clearInfo: true));
  }
}
