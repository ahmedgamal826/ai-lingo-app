import 'package:flutter/material.dart';
// import 'package:flutter_application_1/Core/shared/custom_text.dart';
import '../theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'custom_text.dart';
// import 'package:nti_final/constants/app_colors.dart';
// import 'package:nti_final/shared/custom_text.dart';

class CustomDarkButton extends StatelessWidget {
  const CustomDarkButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.leading,
    this.height = 50,
    this.borderRadius = 8,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final Widget? leading;
  final double height;
  final double borderRadius;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width ?? 350,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) ...[
                leading!,
                SizedBox(width: 7.w),
              ],
              CustomText(text: text, color: Colors.white, fontSize: 14.sp),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomLightButton extends StatelessWidget {
  const CustomLightButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50.h,
        width: width ?? 350,

        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: AppColors.primary,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}

class CustomRedButton extends StatelessWidget {
  const CustomRedButton({
    super.key,
    this.onTap,
    required this.text,
    this.width,
    this.height = 50,
    this.borderRadius = 8,
  });
  final VoidCallback? onTap;
  final String text;
  final double? width;
  final double height;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height.h,
        width: width ?? 350,
        decoration: BoxDecoration(
          color: AppColors.errorLight,
          borderRadius: BorderRadius.circular(borderRadius.r),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: AppColors.danger,
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
