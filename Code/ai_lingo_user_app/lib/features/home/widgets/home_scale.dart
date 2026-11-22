import 'package:flutter/material.dart';

import '../../../core/theme/app_dimensions.dart';

/// Scales Figma values from the 390 design width.
double homeScale(BuildContext context, double value) {
  final width = MediaQuery.sizeOf(context).width;
  final factor = (width / AppDimensions.designWidth).clamp(0.85, 1.25);
  return value * factor;
}
