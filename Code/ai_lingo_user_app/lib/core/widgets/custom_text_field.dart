import 'package:flutter/material.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_font_sizes.dart';


class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    this.hint,
    this.icon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.validator,
    this.onSubmitted,
    this.autofillHints,
    this.showLabel = true,
    this.maxLines = 1,
    this.minLines,
    this.filled = false,
    this.fillColor = AppColors.white,
    this.contentPadding,
    this.borderRadius = AppDimensions.radiusMd,
    this.fontSize = AppFontSizes.font13,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
  });

  final TextEditingController controller;
  final String label;
  final String? hint;
  final IconData? icon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final VoidCallback? onSubmitted;
  final Iterable<String>? autofillHints;
  final bool showLabel;
  final int? maxLines;
  final int? minLines;
  final bool filled;
  final Color fillColor;
  final EdgeInsetsGeometry? contentPadding;
  final double borderRadius;
  final double fontSize;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;

  @override
  // State<CustomTextField> createState() => _CustomTextField();
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscure = widget.obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      obscureText: _obscure,
      keyboardType: widget.keyboardType,
      textInputAction: widget.textInputAction,
      validator: widget.validator,
      autofillHints: widget.autofillHints,
      maxLines: widget.maxLines,
      minLines: widget.minLines,
      textCapitalization: widget.textCapitalization,
      onChanged: widget.onChanged,
      style: TextStyle(
        color: AppColors.textPrimary,
        fontSize: widget.fontSize,
      ),
      onFieldSubmitted:
          widget.onSubmitted == null ? null : (_) => widget.onSubmitted!(),
      decoration: InputDecoration(
        labelText: widget.showLabel && widget.label.isNotEmpty
            ? widget.label
            : null,
        hintText: widget.hint,
        filled: widget.filled,
        fillColor: widget.fillColor,
        contentPadding: widget.contentPadding ??
            const EdgeInsets.symmetric(horizontal: AppDimensions.paddingMd, vertical: 14),
        prefixIcon: widget.icon == null ? null : Icon(widget.icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.indicatorInactive),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.indicatorInactive),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                tooltip: _obscure ? 'Show password' : 'Hide password',
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              )
            : null,
      ),
    );
  }
}
