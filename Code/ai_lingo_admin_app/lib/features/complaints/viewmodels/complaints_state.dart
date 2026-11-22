import '../models/complaint_models.dart';

enum ComplaintsStatus { initial, loading, ready, loadingMore, error }

class ComplaintsState {
  const ComplaintsState({
    required this.status,
    required this.items,
    required this.statusTab,
    required this.sort,
    required this.searchQuery,
    required this.isSearchActive,
    required this.categories,
    required this.allCount,
    required this.pendingCount,
    required this.resolvedCount,
    required this.filteredTotal,
    required this.hasMore,
    required this.pageSize,
    this.selectedCategory,
    this.errorMessage,
  });

  factory ComplaintsState.initial() {
    return const ComplaintsState(
      status: ComplaintsStatus.initial,
      items: [],
      statusTab: ComplaintStatusTab.all,
      sort: ComplaintSort.newestFirst,
      searchQuery: '',
      isSearchActive: false,
      categories: [],
      selectedCategory: null,
      allCount: 0,
      pendingCount: 0,
      resolvedCount: 0,
      filteredTotal: 0,
      hasMore: false,
      pageSize: 3,
    );
  }

  final ComplaintsStatus status;
  final List<ComplaintItem> items;
  final ComplaintStatusTab statusTab;
  final ComplaintSort sort;
  final String searchQuery;
  final bool isSearchActive;
  final List<String> categories;
  final String? selectedCategory;
  final int allCount;
  final int pendingCount;
  final int resolvedCount;
  final int filteredTotal;
  final bool hasMore;
  final int pageSize;
  final String? errorMessage;

  bool get isLoading =>
      status == ComplaintsStatus.loading || status == ComplaintsStatus.initial;

  bool get isLoadingMore => status == ComplaintsStatus.loadingMore;

  String get filterLabel {
    final category = selectedCategory ?? 'All categories';
    final sortLabel = sort == ComplaintSort.newestFirst
        ? 'Newest first'
        : 'Oldest first';
    return '$category · $sortLabel';
  }

  String get showingLabel =>
      'Showing ${items.length} of $filteredTotal requests';

  ComplaintsState copyWith({
    ComplaintsStatus? status,
    List<ComplaintItem>? items,
    ComplaintStatusTab? statusTab,
    ComplaintSort? sort,
    String? searchQuery,
    bool? isSearchActive,
    List<String>? categories,
    String? selectedCategory,
    bool clearCategory = false,
    int? allCount,
    int? pendingCount,
    int? resolvedCount,
    int? filteredTotal,
    bool? hasMore,
    int? pageSize,
    String? errorMessage,
    bool clearError = false,
  }) {
    return ComplaintsState(
      status: status ?? this.status,
      items: items ?? this.items,
      statusTab: statusTab ?? this.statusTab,
      sort: sort ?? this.sort,
      searchQuery: searchQuery ?? this.searchQuery,
      isSearchActive: isSearchActive ?? this.isSearchActive,
      categories: categories ?? this.categories,
      selectedCategory: clearCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
      allCount: allCount ?? this.allCount,
      pendingCount: pendingCount ?? this.pendingCount,
      resolvedCount: resolvedCount ?? this.resolvedCount,
      filteredTotal: filteredTotal ?? this.filteredTotal,
      hasMore: hasMore ?? this.hasMore,
      pageSize: pageSize ?? this.pageSize,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}
