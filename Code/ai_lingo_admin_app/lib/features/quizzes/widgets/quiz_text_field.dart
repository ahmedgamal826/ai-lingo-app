import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import 'quiz_svg_icon.dart';

/// Label above a white rounded field (matches the Figma forms).
class QuizTextField extends StatelessWidget {
  const QuizTextField({
    super.key,
    required this.label,
    required this.controller,
    this.hint,
    this.suffixIconName,
    this.onSuffixTap,
    this.readOnly = false,
    this.minLines,
    this.maxLines = 1,
    this.keyboardType,
  });

  final String label;
  final TextEditingController controller;
  final String? hint;

  /// Optional SVG name from `assets/icons/` shown at the end (e.g. 'calendar').
  final String? suffixIconName;

  /// Called when the field (or its suffix icon) is tapped. Use with [readOnly]
  /// for fields that open a picker instead of the keyboard.
  final VoidCallback? onSuffixTap;
  final bool readOnly;
  final int? minLines;
  final int maxLines;
  final TextInputType? keyboardType;

  OutlineInputBorder _border(Color color) => OutlineInputBorder(
    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
    borderSide: BorderSide(color: color),
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 6.h),
        TextField(
          controller: controller,
          readOnly: readOnly,
          onTap: readOnly ? onSuffixTap : null,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType,
          style: TextStyle(fontSize: 12.sp, color: AppColors.textPrimary),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textSecondary,
            ),
            filled: true,
            fillColor: AppColors.white,
            isDense: true,
            contentPadding: EdgeInsets.symmetric(
              horizontal: 14.w,
              vertical: 16.h,
            ),
            suffixIcon: suffixIconName == null
                ? null
                : GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: onSuffixTap,
              child: Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: QuizSvgIcon(
                  suffixIconName!,
                  size: 18.w,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(),
            enabledBorder: _border(AppColors.indicatorInactive),
            focusedBorder: _border(AppColors.primary),
          ),
        ),
      ],
    );
  }
}