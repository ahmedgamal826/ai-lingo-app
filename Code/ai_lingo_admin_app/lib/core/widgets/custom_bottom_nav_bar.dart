import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';

class BottomNavItem {
  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    this.iconAsset,
    this.activeIconAsset,
  });

  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String? iconAsset;
  final String? activeIconAsset;
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

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: Color(0xFFE9EBF3), width: 0.7),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 58.h,
          child: Row(
            children: [
              for (var index = 0; index < items.length; index++)
                Expanded(
                  child: _BottomNavDestination(
                    item: items[index],
                    selected: currentIndex == index,
                    onTap: () => onTap(index),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavDestination extends StatelessWidget {
  const _BottomNavDestination({
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final BottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected
        ? AppColors.primary
        : const Color(0xFF8B91A8);
    final asset = selected
        ? (item.activeIconAsset ?? item.iconAsset)
        : item.iconAsset;

    return Semantics(
      button: true,
      selected: selected,
      label: item.label,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (asset != null)
                SvgPicture.asset(
                  asset,
                  width: 19.w,
                  height: 19.w,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                )
              else
                Icon(
                  selected ? (item.activeIcon ?? item.icon) : item.icon,
                  size: 19.w,
                  color: color,
                ),
              SizedBox(height: 3.h),
              Text(
                item.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 8.sp,
                  height: 1.1,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w400,
                  color: color,
                ),
              ),
              SizedBox(height: 3.h),
              Container(
                width: 3.w,
                height: 3.w,
                decoration: BoxDecoration(
                  color: selected ? AppColors.primary : Colors.transparent,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
