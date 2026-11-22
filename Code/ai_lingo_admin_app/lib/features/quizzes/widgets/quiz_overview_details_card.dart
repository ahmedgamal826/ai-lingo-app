import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import 'custom_card.dart';
import 'quiz_svg_icon.dart';

/// One line inside [QuizOverviewDetailsCard].
class QuizDetailRow {
  const QuizDetailRow({
    required this.iconName,
    required this.title,
    this.subtitle,
  });

  /// SVG name from `assets/icons/` (e.g. 'clock').
  final String iconName;
  final String title;
  final String? subtitle;
}

/// White card listing level / duration / schedule, separated by dividers.
class QuizOverviewDetailsCard extends StatelessWidget {
  const QuizOverviewDetailsCard({super.key, required this.rows});

  final List<QuizDetailRow> rows;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              Divider(
                height: 24.h,
                thickness: 1,
                color: AppColors.indicatorInactive,
              ),
            _DetailRowTile(row: rows[i]),
          ],
        ],
      ),
    );
  }
}

class _DetailRowTile extends StatelessWidget {
  const _DetailRowTile({required this.row});

  final QuizDetailRow row;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 36.w,
          height: 36.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.primaryLight,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: QuizSvgIcon(row.iconName, size: 18.w, color: AppColors.primary),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                row.title,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
              if (row.subtitle != null) ...[
                SizedBox(height: 2.h),
                Text(
                  row.subtitle!,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}