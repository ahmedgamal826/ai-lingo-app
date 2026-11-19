import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_assets.dart';

/// Draws an SVG from `assets/icons/` by its file name (without `.svg`).
///
/// File names are case-sensitive: use `'Edit'` for `Edit.svg`.
class DashboardSvgIcon extends StatelessWidget {
  const DashboardSvgIcon(this.name, {super.key, this.size = 20, this.color});

  final String name;
  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.icon('$name.svg'),
      width: size,
      height: size,
      colorFilter: color == null
          ? null
          : ColorFilter.mode(color!, BlendMode.srcIn),
    );
  }
}