import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/core/widgets/custom_card.dart';
import 'package:flutter/material.dart';

/// Page 2
class Page2 extends StatelessWidget {
  const Page2();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: CustomCard(
            backgroundColor: AppColors.white,
            elevation: 0,
            borderRadius: BorderRadius.circular(14),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: const Text(
              'Hi! What can I get you today?',
              style: TextStyle(fontSize: 8, color: AppColors.textPrimary),
            ),
          ),
        ),
        const SizedBox(height: 8),
        SizedBox(
          width: double.infinity,
          child: CustomCard(
            backgroundColor: AppColors.primary,
            elevation: 0,
            borderRadius: BorderRadius.circular(14),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: const Text(
              "I'd love a cappuccino, please.",
              style: TextStyle(fontSize: 8, color: AppColors.white),
            ),
          ),
        ),
        const SizedBox(height: 8),
        const CustomStatusBadge(
          label: 'Great choice of words!',
          tone: CustomTone.success,
        ),
      ],
    );
  }
}
