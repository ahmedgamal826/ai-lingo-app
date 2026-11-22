import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_font_sizes.dart';

class VocabularyFieldLabel extends StatelessWidget {
  const VocabularyFieldLabel(this.label, {super.key});

  final String label;

  @override
  Widget build(BuildContext context) => Text(
        label,
        style: const TextStyle(
          color: AppColors.textPrimary,
          fontSize: AppFontSizes.font11,
          fontWeight: FontWeight.w600,
        ),
      );
}
