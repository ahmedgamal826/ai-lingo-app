import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../../../core/widgets/custom_text_field.dart';

class VocabularyTextField extends StatelessWidget {
  const VocabularyTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    this.maxLines = 1,
    this.minLines,
    this.capitalization = TextCapitalization.none,
    this.validator,
  });

  final TextEditingController controller;
  final String label;
  final String hint;
  final int? maxLines;
  final int? minLines;
  final TextCapitalization capitalization;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      label: label,
      showLabel: false,
      hint: hint,
      maxLines: maxLines,
      minLines: minLines,
      textCapitalization: capitalization,
      textInputAction:
          maxLines == 1 ? TextInputAction.next : TextInputAction.newline,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
      fontSize: AppFontSizes.font12,
      validator: validator,
    );
  }
}
