import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProgressLevelCaption extends StatelessWidget {
  const ProgressLevelCaption({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'B1 Intermediate · Learning since Oct 12, 2026',
        style: TextStyle(
          color: AppColors.textSecondary,
          fontSize: 10,
        ),
      ),
    );
  }
}
