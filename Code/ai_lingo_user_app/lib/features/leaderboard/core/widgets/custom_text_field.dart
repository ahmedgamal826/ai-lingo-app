import 'package:flutter/material.dart';

import '../../../../core/theme/app_dimensions.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.readOnly = false,
    this.onChanged,
    this.onFieldSubmitted,
    this.onTap,
    this.maxLines = 1,
    this.enabled = true,
    this.filled,
    this.fillColor,
    this.contentPadding,
    this.border,
    this.enabledBorder,
    this.focusedBorder,
    this.disabledBorder,
    this.hintStyle,
    this.style,
    this.isDense,
  });

  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final bool readOnly;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onFieldSubmitted;
  final VoidCallback? onTap;
  final int maxLines;
  final bool enabled;
  final bool? filled;
  final Color? fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? border;
  final InputBorder? enabledBorder;
  final InputBorder? focusedBorder;
  final InputBorder? disabledBorder;
  final TextStyle? hintStyle;
  final TextStyle? style;
  final bool? isDense;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      validator: validator,
      readOnly: readOnly,
      enabled: enabled,
      maxLines: maxLines,
      onTap: onTap,
      onChanged: onChanged,
      onFieldSubmitted: onFieldSubmitted,
      style: style,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        labelText: label,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: filled,
        fillColor: fillColor,
        isDense: isDense,
        contentPadding:
            contentPadding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingMd,
            ),
        border: border,
        enabledBorder: enabledBorder,
        focusedBorder: focusedBorder,
        disabledBorder: disabledBorder,
      ),
    );
  }
}
