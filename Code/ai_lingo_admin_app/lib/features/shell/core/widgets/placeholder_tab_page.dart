import 'package:flutter/material.dart';

import '../../../../core/theme/app_text_styles.dart';

/// Temporary empty tab body until a feature screen is implemented.
class PlaceholderTabPage extends StatelessWidget {
  const PlaceholderTabPage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      body: SafeArea(
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.placeholderTitle,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
