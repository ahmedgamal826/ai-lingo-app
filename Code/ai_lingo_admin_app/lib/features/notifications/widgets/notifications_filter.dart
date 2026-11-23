import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../widgets_core/custom_text.dart';

class NotificationsFilter extends StatelessWidget {
  const NotificationsFilter({
    super.key,
    required this.selectedFilter,
    required this.unreadCount,
    required this.onFilterChanged,
  });

  final int selectedFilter;
  final int unreadCount;
  final ValueChanged<int> onFilterChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.h,
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: const Color(0xFFE9EBF3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          _filterOption('All', 0),
          _filterOption('Unread ┬╖ $unreadCount', 1),
        ],
      ),
    );
  }

  Widget _filterOption(String label, int index) {
    final selected = selectedFilter == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onFilterChanged(index),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppColors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(9.r),
          ),
          child: CustomText(
            text: label,
            fontSize: 12.sp,
            fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            color: selected ? AppColors.primary : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
