import 'package:flutter/material.dart';

import '../../../core/constants/app_strings.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../models/complaint_models.dart';

class ComplaintStatusTabs extends StatelessWidget {
  const ComplaintStatusTabs({
    super.key,
    required this.selected,
    required this.allCount,
    required this.pendingCount,
    required this.onChanged,
  });

  final ComplaintStatusTab selected;
  final int allCount;
  final int pendingCount;
  final ValueChanged<ComplaintStatusTab> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Expanded(
            child: _TabButton(
              label: '${AppStrings.complaintsTabAll} · $allCount',
              selected: selected == ComplaintStatusTab.all,
              onTap: () => onChanged(ComplaintStatusTab.all),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _TabButton(
              label: '${AppStrings.complaintsTabPending} · $pendingCount',
              selected: selected == ComplaintStatusTab.pending,
              onTap: () => onChanged(ComplaintStatusTab.pending),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _TabButton(
              label: AppStrings.complaintsTabResolved,
              selected: selected == ComplaintStatusTab.resolved,
              onTap: () => onChanged(ComplaintStatusTab.resolved),
            ),
          ),
        ],
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  const _TabButton({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: selected ? AppColors.white : AppColors.indicatorInactive,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: SizedBox(
          height: double.infinity,
          child: Center(
            child: Text(
              label,
              style: selected
                  ? AppTextStyles.tabLabelActive
                  : AppTextStyles.tabLabel,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ),
    );
  }
}
