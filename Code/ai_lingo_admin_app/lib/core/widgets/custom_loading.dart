import 'package:flutter/material.dart';

import '../constants/app_strings.dart';
import '../theme/app_dimensions.dart';
import 'custom_text.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading({
    super.key,
    this.message,
    this.color,
    this.size = AppDimensions.iconLg,
  });

  final String? message;
  final Color? color;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              color: color,
            ),
          ),
          if (message != null) ...[
            const SizedBox(height: AppDimensions.spaceMd),
            CustomText(message!),
          ],
        ],
      ),
    );
  }

  /// Full-screen overlay helper.
  static Widget overlay({String? message}) {
    return ColoredBox(
      color: Colors.black54,
      child: CustomLoading(
        message: message ?? AppStrings.loading,
        color: Colors.white,
      ),
    );
  }
}
