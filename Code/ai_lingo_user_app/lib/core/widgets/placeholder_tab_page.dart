import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';
import 'custom_text.dart';

/// Temporary empty tab body used until a feature screen is implemented.
class PlaceholderTabPage extends StatelessWidget {
  const PlaceholderTabPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: CustomText(
            title,
            style: AppTextStyles.appBarTitle.copyWith(
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
