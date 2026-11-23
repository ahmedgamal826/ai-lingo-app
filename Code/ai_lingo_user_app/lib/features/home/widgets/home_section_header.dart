import 'package:flutter/material.dart';

import '../../../core/theme/app_text_styles.dart';
import '../core/widgets/custom_text.dart';

class HomeSectionHeader extends StatelessWidget {
  const HomeSectionHeader({
    super.key,
    required this.title,
    required this.actionLabel,
    this.onActionTap,
  });

  final String title;
  final String actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: CustomText(title, style: AppTextStyles.sectionTitle)),
        GestureDetector(
          onTap: onActionTap,
          child: CustomText(actionLabel, style: AppTextStyles.link),
        ),
      ],
    );
  }
}
