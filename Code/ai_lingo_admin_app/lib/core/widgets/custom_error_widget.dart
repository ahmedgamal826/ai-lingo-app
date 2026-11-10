import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_dimensions.dart';
import 'custom_button.dart';
import 'custom_text.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({
    super.key,
    this.message,
    this.onRetry,
    this.retryLabel,
  });

  final String? message;
  final VoidCallback? onRetry;
  final String? retryLabel;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDimensions.paddingLg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline,
              size: AppDimensions.iconLg * 1.5,
            ),
            const SizedBox(height: AppDimensions.spaceMd),
            CustomText(
              message ?? AppStrings.somethingWentWrong,
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDimensions.spaceLg),
              CustomButton(
                title: retryLabel ?? AppStrings.retry,
                onPressed: onRetry,
                width: 160,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
