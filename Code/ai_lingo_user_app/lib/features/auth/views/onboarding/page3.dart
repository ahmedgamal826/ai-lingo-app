import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// Page 3
class Page3 extends StatelessWidget {
  const Page3();

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Possibility',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textPrimary,
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/volume.svg',
                  width: 12,
                  height: 12,
                ),
              ],
            ),
            const SizedBox(height: 4),
            const Text(
              '/ˌpɒsəˈbɪləti/ · noun',
              style: TextStyle(fontSize: 6, color: AppColors.textSecondary),
            ),
            const SizedBox(height: 6),
            const Text(
              'A chance that something may happen.',
              style: TextStyle(fontSize: 7, color: AppColors.textPrimary),
            ),
            const SizedBox(height: 8),
            const CustomStatusBadge(
              label: 'Added to your vocabulary',
              tone: CustomTone.success,
            ),
          ],
        ),
      ),
    );
  }
}
