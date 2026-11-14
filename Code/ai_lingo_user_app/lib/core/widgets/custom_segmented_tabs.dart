import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import 'custom_text.dart';

class SegmentedTabItem {
  const SegmentedTabItem({required this.id, required this.label});

  final String id;
  final String label;
}

/// Shared segmented control matching Figma (radius 14, height 44).
class CustomSegmentedTabs extends StatelessWidget {
  const CustomSegmentedTabs({
    super.key,
    required this.items,
    required this.selectedId,
    required this.onChanged,
  });

  final List<SegmentedTabItem> items;
  final String selectedId;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppDimensions.segmentedHeight,
      padding: const EdgeInsets.all(AppDimensions.spaceXs),
      decoration: BoxDecoration(
        color: AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(AppDimensions.radiusButton),
      ),
      child: Row(
        children: [
          for (var i = 0; i < items.length; i++) ...[
            if (i > 0) const SizedBox(width: AppDimensions.spaceXs),
            Expanded(
              child: _SegmentChip(
                label: items[i].label,
                selected: items[i].id == selectedId,
                onTap: () => onChanged(items[i].id),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
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
        child: Center(
          child: CustomText(
            label,
            style: selected
                ? AppTextStyles.tabLabelActive
                : AppTextStyles.tabLabel,
          ),
        ),
      ),
    );
  }
}
