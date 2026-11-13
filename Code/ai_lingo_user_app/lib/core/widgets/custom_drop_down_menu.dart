import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';

/// Reusable single-selection dropdown. Generic <T> so it works with
/// String, enums, or any model.
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
  });

  final List<T> items;
  final T? value; // currently selected item (null = nothing selected)
  final ValueChanged<T?> onChanged;
  final String Function(T item) itemLabel; // how to show each item as text
  final String? label; // small title above the field
  final String? hint; // placeholder when nothing is selected
  final String? Function(T?)? validator; // for Forms
  final bool enabled;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Text(
            label!,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: AppDimensions.spaceSm),
        ],
        DropdownButtonFormField<T>(
          value: value,
          isExpanded: true,
          validator: validator,
          dropdownColor: AppColors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          icon: const Icon(
            Icons.keyboard_arrow_down_rounded,
            color: AppColors.textSecondary,
          ),
          hint: hint == null
              ? null
              : Text(
            hint!,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.spaceMd,
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
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          )
              .toList(),
          onChanged: enabled ? onChanged : null,
        ),
      ],
    );
  }
}