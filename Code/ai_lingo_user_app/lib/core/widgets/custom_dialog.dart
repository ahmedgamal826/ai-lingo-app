import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_dimensions.dart';
import 'custom_text.dart';

class CustomDialog {
  CustomDialog._();

  static Future<bool?> showConfirm(
    BuildContext context, {
    required String title,
    required String message,
    String? confirmLabel,
    String? cancelLabel,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(title),
          content: CustomText(message),
          actionsPadding: const EdgeInsets.fromLTRB(
            AppDimensions.paddingMd,
            0,
            AppDimensions.paddingMd,
            AppDimensions.paddingMd,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(cancelLabel ?? AppStrings.cancel),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text(confirmLabel ?? AppStrings.confirm),
            ),
          ],
        );
      },
    );
  }

  static Future<void> showInfo(
    BuildContext context, {
    required String title,
    required String message,
  }) {
    return showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: CustomText(title),
          content: CustomText(message),
          actions: [
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(AppStrings.confirm),
            ),
          ],
        );
      },
    );
  }
}
