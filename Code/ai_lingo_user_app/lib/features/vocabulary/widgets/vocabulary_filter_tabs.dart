import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_font_sizes.dart';

class VocabularyFilterTabs extends StatelessWidget {
  const VocabularyFilterTabs({
    super.key,
    required this.selectedFilter,
    required this.favoriteCount,
    required this.allWordsCount,
    required this.onChanged,
  });

  final int selectedFilter;
  final int favoriteCount;
  final int allWordsCount;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(child: _tab('All words · $allWordsCount', 0)),
          Expanded(child: _tab('Favorites · $favoriteCount', 1)),
        ],
      ),
    );
  }

  Widget _tab(String label, int index) {
    final selected = selectedFilter == index;
    return GestureDetector(
      onTap: () => onChanged(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 160),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.white : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? AppColors.primary : AppColors.textSecondary,
            fontSize: AppFontSizes.font11,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
