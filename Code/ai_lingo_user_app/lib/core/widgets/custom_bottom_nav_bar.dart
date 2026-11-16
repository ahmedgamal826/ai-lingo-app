import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/app_colors.dart';
import '../theme/app_dimensions.dart';
import '../theme/app_text_styles.dart';
import 'custom_text.dart';

class BottomNavItem {
  const BottomNavItem({
    required this.label,
    this.icon,
    this.iconAsset,
    this.activeIcon,
    this.activeIconAsset,
  }) : assert(
         icon != null || iconAsset != null,
         'Provide either icon or iconAsset',
       );

  final String label;
  final IconData? icon;
  final String? iconAsset;
  final IconData? activeIcon;
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
    return Material(
      color: AppColors.white,
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: AppDimensions.bottomNavHeight,
          child: DecoratedBox(
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                top: BorderSide(color: AppColors.indicatorInactive, width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppDimensions.paddingSm + 2,
                10,
                AppDimensions.paddingSm + 2,
                6,
              ),
              child: Row(
                children: [
                  for (var i = 0; i < items.length; i++)
                    Expanded(
                      child: _BottomNavTile(
                        key: ValueKey<String>('nav_${items[i].label}'),
                        item: items[i],
                        selected: i == currentIndex,
                        onTap: () => onTap(i),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavTile extends StatelessWidget {
  const _BottomNavTile({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final BottomNavItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = selected ? AppColors.primary : AppColors.textSecondary;
    final asset = selected
        ? (item.activeIconAsset ?? item.iconAsset)
        : item.iconAsset;

    return RepaintBoundary(
      child: InkWell(
        onTap: onTap,
        splashColor: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (asset != null)
              SvgPicture.asset(
                asset,
                width: AppDimensions.navIconSize,
                height: AppDimensions.navIconSize,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              )
            else
              Icon(
                selected ? (item.activeIcon ?? item.icon!) : item.icon!,
                size: AppDimensions.navIconSize,
                color: color,
              ),
            const SizedBox(height: 5),
            CustomText(
              item.label,
              style:
                  (selected
                          ? AppTextStyles.navLabelActive
                          : AppTextStyles.navLabel)
                      .copyWith(color: color),
              maxLines: 1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 3),
            SizedBox(
              height: AppDimensions.navIndicatorSize,
              child: selected
                  ? Container(
                      width: AppDimensions.navIndicatorSize,
                      height: AppDimensions.navIndicatorSize,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
