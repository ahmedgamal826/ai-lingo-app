import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';


class BottomNavItem {
  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.iconAsset,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String? iconAsset;
}

class CustomBottomNavBar extends StatelessWidget {
  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.items,
    required this.onTap,
  });

  final int currentIndex;
  final List<BottomNavItem> items;
  final ValueChanged<int> onTap;

  Widget _buildItemIcon(BottomNavItem item, {required bool selected}) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    if (item.iconAsset != null) {
      return SvgPicture.asset(
        item.iconAsset!,
        width: 20,
        height: 20,
        colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
      );
    }
    return Icon(
      selected ? (item.activeIcon ?? item.icon) : item.icon,
      size: 20,
      color: color,
    );
  }

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      height: AppDimensions.bottomNavHeight,
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      destinations: [
        for (final item in items)
          NavigationDestination(
            icon: _buildItemIcon(item, selected: false),
            selectedIcon: _buildItemIcon(item, selected: true),
            label: item.label,
          ),
      ],
    );
  }
}
