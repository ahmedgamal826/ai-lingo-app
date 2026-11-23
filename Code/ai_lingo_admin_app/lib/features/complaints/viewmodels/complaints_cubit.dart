import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/complaint_models.dart';
import '../services/complaints_service.dart';
import '../services/mock_complaints_service.dart';
import 'complaints_state.dart';

/// ViewModel for the Admin Complaints screen.
class ComplaintsCubit extends Cubit<ComplaintsState> {
  ComplaintsCubit({ComplaintsService? service})
    : _service = service ?? MockComplaintsService.instance,
      super(ComplaintsState.initial()) {
    _bootstrap();
  }

  final ComplaintsService _service;
  Timer? _searchDebounce;
  int _requestId = 0;

  Future<void> _bootstrap() async {
    emit(state.copyWith(status: ComplaintsStatus.loading, clearError: true));
    try {
      final categories = await _service.fetchCategories();
      if (isClosed) return;
      emit(state.copyWith(categories: categories));
      await refresh();
    } catch (_) {
      if (isClosed) return;
      emit(
        state.copyWith(
          status: ComplaintsStatus.error,
          errorMessage: 'Could not load complaints.',
        ),
      );
    }
  }

  Future<void> refresh() async {
    final requestId = ++_requestId;
    emit(
      state.copyWith(
        status: ComplaintsStatus.loading,
        items: const [],
        clearError: true,
      ),
    );

    try {
      final page = await _service.fetchComplaints(
        ComplaintsQuery(
          statusTab: state.statusTab,
          category: state.selectedCategory,
          sort: state.sort,
          searchQuery: state.searchQuery,
          offset: 0,
          limit: state.pageSize,
        ),
      );
      if (isClosed || requestId != _requestId) return;
      emit(
        state.copyWith(
          status: ComplaintsStatus.ready,
          items: page.items,
          allCount: page.allCount,
          pendingCount: page.pendingCount,
          resolvedCount: page.resolvedCount,
          filteredTotal: page.filteredTotal,
          hasMore: page.hasMore,
        ),
      );
    } catch (_) {
      if (isClosed || requestId != _requestId) return;
      emit(
        state.copyWith(
          status: ComplaintsStatus.error,
          errorMessage: 'Could not load complaints.',
        ),
      );
    }
  }

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore || state.isLoading) return;
    final requestId = ++_requestId;
    emit(
      state.copyWith(status: ComplaintsStatus.loadingMore, clearError: true),
    );

    try {
      final page = await _service.fetchComplaints(
        ComplaintsQuery(
          statusTab: state.statusTab,
          category: state.selectedCategory,
          sort: state.sort,
          searchQuery: state.searchQuery,
          offset: state.items.length,
          limit: state.pageSize,
        ),
      );
      if (isClosed || requestId != _requestId) return;

      final merged = [...state.items];
      for (final item in page.items) {
        if (!merged.any((existing) => existing.id == item.id)) {
          merged.add(item);
        }
      }

      emit(
        state.copyWith(
          status: ComplaintsStatus.ready,
          items: merged,
          filteredTotal: page.filteredTotal,
          allCount: page.allCount,
          pendingCount: page.pendingCount,
          resolvedCount: page.resolvedCount,
          hasMore: page.hasMore,
        ),
      );
    } catch (_) {
      if (isClosed || requestId != _requestId) return;
      emit(
        state.copyWith(
          status: ComplaintsStatus.ready,
          errorMessage: 'Could not load more complaints.',
        ),
      );
    }
  }

  void selectStatusTab(ComplaintStatusTab tab) {
    if (tab == state.statusTab) return;
    emit(state.copyWith(statusTab: tab));
    refresh();
  }

  void toggleSearch(bool active) {
    if (active == state.isSearchActive) return;
    if (!active && state.searchQuery.isNotEmpty) {
      emit(state.copyWith(isSearchActive: false, searchQuery: ''));
      refresh();
      return;
    }
    emit(state.copyWith(isSearchActive: active));
  }

  void updateSearchQuery(String query) {
    emit(state.copyWith(searchQuery: query));
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 280), refresh);
  }

  void clearSearch() {
    _searchDebounce?.cancel();
    emit(state.copyWith(searchQuery: '', isSearchActive: false));
    refresh();
  }

  void applyFilters({String? category, required ComplaintSort sort}) {
    emit(
      state.copyWith(
        selectedCategory: category,
        clearCategory: category == null,
        sort: sort,
      ),
    );
    refresh();
  }

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    return super.close();
  }
}
