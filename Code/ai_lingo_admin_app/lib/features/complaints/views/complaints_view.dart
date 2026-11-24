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
import '../viewmodels/complaints_cubit.dart';
import '../viewmodels/complaints_state.dart';
import '../widgets/complaint_card.dart';
import '../widgets/complaint_status_tabs.dart';
import 'complaint_details_view.dart';

/// Admin Complaints screen (Figma node 6:79455).
class ComplaintsView extends StatelessWidget {
  const ComplaintsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ComplaintsCubit(),
      child: const _ComplaintsViewBody(),
    );
  }
}

class _ComplaintsViewBody extends StatefulWidget {
  const _ComplaintsViewBody();

  @override
  State<_ComplaintsViewBody> createState() => _ComplaintsViewBodyState();
}

class _ComplaintsViewBodyState extends State<_ComplaintsViewBody> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _openFilterSheet(
    BuildContext context,
    ComplaintsState state,
  ) async {
    var draftCategory = state.selectedCategory;
    var draftSort = state.sort;

    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      AppStrings.complaintsFilterTitle,
                      style: AppTextStyles.complaintTitle,
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),
                    Text('Category', style: AppTextStyles.filterMeta),
                    const SizedBox(height: AppDimensions.spaceSm),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        ChoiceChip(
                          label: const Text(AppStrings.complaintsCategoryAll),
                          selected: draftCategory == null,
                          onSelected: (_) {
                            setModalState(() => draftCategory = null);
                          },
                        ),
                        for (final category in state.categories)
                          ChoiceChip(
                            label: Text(category),
                            selected: draftCategory == category,
                            onSelected: (_) {
                              setModalState(() => draftCategory = category);
                            },
                          ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spaceLg),
                    Text('Sort', style: AppTextStyles.filterMeta),
                    const SizedBox(height: AppDimensions.spaceSm),
                    _SortOption(
                      label: AppStrings.complaintsSortNewest,
                      selected: draftSort == ComplaintSort.newestFirst,
                      onTap: () {
                        setModalState(
                          () => draftSort = ComplaintSort.newestFirst,
                        );
                      },
                    ),
                    _SortOption(
                      label: AppStrings.complaintsSortOldest,
                      selected: draftSort == ComplaintSort.oldestFirst,
                      onTap: () {
                        setModalState(
                          () => draftSort = ComplaintSort.oldestFirst,
                        );
                      },
                    ),
                    const SizedBox(height: AppDimensions.spaceMd),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ComplaintsCubit>().applyFilters(
                          category: draftCategory,
                          sort: draftSort,
                        );
                        Navigator.pop(sheetContext);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: AppColors.white,
                        elevation: 0,
                        minimumSize: const Size.fromHeight(48),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(AppStrings.complaintsApply),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ComplaintsCubit, ComplaintsState>(
      listenWhen: (previous, current) =>
          previous.errorMessage != current.errorMessage &&
          current.errorMessage != null,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
      },
      builder: (context, state) {
        final cubit = context.read<ComplaintsCubit>();
        if (!state.isSearchActive && _searchController.text.isNotEmpty) {
          _searchController.clear();
        }

        return Scaffold(
          backgroundColor: const Color(0xFFF7F8FC),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 12, 12, 0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppStrings.complaintsTitle,
                              style: AppTextStyles.pageTitle,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              AppStrings.complaintsSubtitle,
                              style: AppTextStyles.pageSubtitle,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        onPressed: () => _openFilterSheet(context, state),
                        icon: SvgPicture.asset(
                          AppAssets.slidersHorizontal,
                          width: 22,
                          height: 22,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      children: [
                        ComplaintStatusTabs(
                          selected: state.statusTab,
                          allCount: state.allCount,
                          pendingCount: state.pendingCount,
                          onChanged: cubit.selectStatusTab,
                        ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        if (state.isSearchActive)
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  controller: _searchController,
                                  autofocus: true,
                                  onChanged: cubit.updateSearchQuery,
                                  decoration: InputDecoration(
                                    hintText: AppStrings.complaintsSearchHint,
                                    isDense: true,
                                    filled: true,
                                    fillColor: AppColors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 12,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: AppColors.indicatorInactive,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: AppColors.indicatorInactive,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: cubit.clearSearch,
                                child: const Text(
                                  AppStrings.complaintsClearSearch,
                                ),
                              ),
                            ],
                          )
                        else
                          Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => _openFilterSheet(context, state),
                                  child: Text(
                                    state.filterLabel,
                                    style: AppTextStyles.filterMeta,
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () => cubit.toggleSearch(true),
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: SvgPicture.asset(
                                    AppAssets.search,
                                    width: 18,
                                    height: 18,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        const SizedBox(height: AppDimensions.spaceLg),
                        Expanded(child: _ComplaintsList(state: state)),
                      ],
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

class _SortOption extends StatelessWidget {
  const _SortOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
      leading: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? AppColors.primary : AppColors.textSecondary,
      ),
      title: Text(label),
    );
  }
}

class _ComplaintsList extends StatelessWidget {
  const _ComplaintsList({required this.state});

  final ComplaintsState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ComplaintsCubit>();

    if (state.isLoading && state.items.isEmpty) {
      return const Center(child: CustomLoading());
    }

    if (state.status == ComplaintsStatus.error && state.items.isEmpty) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.errorMessage ?? AppStrings.somethingWentWrong,
              style: AppTextStyles.filterMeta,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            TextButton(
              onPressed: cubit.refresh,
              child: const Text(AppStrings.retry),
            ),
          ],
        ),
      );
    }

    if (state.items.isEmpty) {
      return Center(
        child: Text(
          AppStrings.complaintsEmpty,
          style: AppTextStyles.filterMeta,
          textAlign: TextAlign.center,
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 20),
      itemCount: state.items.length + 1,
      separatorBuilder: (context, index) => const SizedBox(height: AppDimensions.spaceLg),
      itemBuilder: (context, index) {
        if (index == state.items.length) {
          return _LoadMoreFooter(state: state, onLoadMore: cubit.loadMore);
        }
        final item = state.items[index];
        return ComplaintCard(
          item: item,
          onTap: () async {
            final updated = await ComplaintDetailsView.open(
              context,
              complaint: item,
            );
            if (updated == true && context.mounted) {
              await cubit.refresh();
            }
          },
        );
      },
    );
  }
}

class _LoadMoreFooter extends StatelessWidget {
  const _LoadMoreFooter({required this.state, required this.onLoadMore});

  final ComplaintsState state;
  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(child: CustomLoading()),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Center(
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Text(
              state.hasMore ? '${state.showingLabel} · ' : state.showingLabel,
              style: AppTextStyles.loadMore,
            ),
            if (state.hasMore)
              GestureDetector(
                onTap: onLoadMore,
                child: Text(
                  AppStrings.complaintsLoadMore,
                  style: AppTextStyles.loadMoreAction,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
