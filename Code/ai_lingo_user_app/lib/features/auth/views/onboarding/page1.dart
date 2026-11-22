import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/core/widgets/custom_card.dart';
import 'package:flutter/material.dart';

/// Page 1
class Page1 extends StatelessWidget {
  const Page1();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CustomCard(
        backgroundColor: AppColors.white,
        elevation: 0,
        borderRadius: BorderRadius.circular(16),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const CustomStatusBadge(
              label: 'YOUR PERSONAL LEARNING PLAN',
              tone: CustomTone.warning,
            ),
            const SizedBox(height: 8),
            const Text(
              'A little better, every day',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'B1 Intermediate · 15 min / day',
              style: TextStyle(fontSize: 7, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 8),
            Row(
              children: List.generate(7, (i) {
                return Expanded(
                  child: Container(
                    height: 3,
                    margin: EdgeInsets.only(right: i == 6 ? 0 : 3),
                    decoration: BoxDecoration(
                      color: i < 4
                          ? AppColors.primary
                          : AppColors.indicatorInactive,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
