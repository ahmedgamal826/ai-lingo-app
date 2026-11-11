import 'package:flutter/material.dart';
import 'package:flutter_application_1/Core/shared/custom_text.dart';
import 'package:flutter_application_1/core/Theme/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:nti_final/constants/app_colors.dart';
// import 'package:nti_final/shared/custom_text.dart';

class CustomDarkButton extends StatelessWidget {
  const CustomDarkButton({
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
        width: 170 ?? 350,
        decoration: BoxDecoration(
          color: Color(0xff5B6CFF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: CustomText(text: text, color: Colors.white, fontSize: 14.sp),
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
          color: Color(0xffEEF0FF),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: Color(0xff5B6CFF),
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
          color: Color(0xffFFF0F3),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Center(
          child: CustomText(
            text: text,
            color: Color(0xffD45B70),
            fontSize: 14.sp,
          ),
        ),
      ),
    );
  }
}
