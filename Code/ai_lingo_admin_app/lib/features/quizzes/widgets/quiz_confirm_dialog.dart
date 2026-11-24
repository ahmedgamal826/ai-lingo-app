import 'package:flutter/material.dart';

/// Confirmation dialog used before destructive actions.
/// Returns `true` only when the admin taps the confirm button.
Future<bool> showQuizConfirmDialog(
    BuildContext context, {
      required String title,
      required String message,
      String confirmLabel = 'Delete',
      String cancelLabel = 'Cancel',
      bool destructive = true,
    }) async {
  final result = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(cancelLabel),
        ),
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(true),
          style: destructive
              ? TextButton.styleFrom(foregroundColor: const Color(0xFFD92D20))
              : null,
          child: Text(confirmLabel),
        ),
      ],
    ),
  );
  return result ?? false;
}