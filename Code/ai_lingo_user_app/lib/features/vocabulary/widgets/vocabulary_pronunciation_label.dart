import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_font_sizes.dart';

class VocabularyPronunciationLabel extends StatelessWidget {
  const VocabularyPronunciationLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: const TextStyle(
          fontSize: AppFontSizes.font11,
          fontWeight: FontWeight.w600,
        ),
        children: const [
          TextSpan(
            text: 'Pronunciation ',
            style: TextStyle(color: AppColors.textPrimary),
          ),
          TextSpan(
            text: '(optional)',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
