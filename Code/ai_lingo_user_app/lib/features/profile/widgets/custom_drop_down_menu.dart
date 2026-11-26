import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/core/theme/app_dimensions.dart';
import 'package:ai_lingo_user_app/core/theme/app_font_sizes.dart';
import 'package:flutter/material.dart';

class CustomDropDownMenu<T> extends StatelessWidget {
  const CustomDropDownMenu({
    super.key,
    required this.items,
    required this.onChanged,
    required this.itemLabel,
    this.value,
    this.label,
    this.hint,
    this.validator,
    this.enabled = true,
    this.fontSize = AppFontSizes.font14,
    this.height = AppDimensions.textFieldHeight,
  });

  final List<T> items;
  final T? value; // currently selected item (null = nothing selected)
  final ValueChanged<T?> onChanged;
  final String Function(T item) itemLabel; // how to show each item as text
  final String? label; // small title above the field
  final String? hint; // placeholder when nothing is selected
  final String? Function(T?)? validator; // for Forms
  final bool enabled;
  final double fontSize;
  final double height;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSm),
        ],
        DropdownButtonFormField<T>(
          key: ValueKey(value),
          initialValue: value,
          isExpanded: true,
          validator: validator,
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          hint: hint == null
              ? null
              : Text(
            hint!,
            style: TextStyle(
              fontSize: fontSize,
              color: AppColors.textSecondary,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingSm,
              vertical: AppDimensions.spaceSm,
            ),
            enabledBorder: _border(AppColors.indicatorInactive),
            disabledBorder: _border(AppColors.indicatorInactive),
            focusedBorder: _border(AppColors.primary),
            errorBorder: _border(AppColors.danger),
            focusedErrorBorder: _border(AppColors.danger),
          ),
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabel(item),
                style: TextStyle(
                  fontSize: fontSize,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          )
              .toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ],
      ),
    );
  }
}