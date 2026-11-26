import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';
import '../../../core/theme/app_font_sizes.dart';
import '../widgets/custom_app_bar.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_drop_down_menu.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_card.dart';


class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key, required this.title, required this.child, this.back = true});
  final String title;
  final Widget child;
  final bool back;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.indicatorInactive,
    appBar: CustomAppBar(
      backgroundColor: AppColors.white,
      centerTitle: false,
      title: title,
      leading: back ? IconButton(
        icon: Transform.rotate(
          angle: 3.14159,
          child: SvgAssetIcon('chevron-right', size: AppDimensions.iconSm, color: AppColors.textPrimary),
        ),
        onPressed: () => Navigator.maybePop(context),
      ) : null,
      actions: title == 'Profile' ? [
        IconButton(
          tooltip: 'Notifications',
          onPressed: () => Navigator.pushNamed(context, '/profile/notifications'),
          icon: const SvgAssetIcon('bell', size: AppDimensions.iconSm, color: AppColors.textPrimary),
        ),
      ] : null,
    ),
    body: SafeArea(child: child),
  );
}

class ProfileBody extends StatelessWidget {
  const ProfileBody({super.key, required this.child, this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 24)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(padding: padding, child: child);
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: CustomText(text: text, color: AppColors.textPrimary, fontSize: AppFontSizes.font12, fontWeight: FontWeight.w700)),
    if (trailing != null) trailing!,
  ]);
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key, required this.child, this.padding = const EdgeInsets.all(14)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => CustomCard(
    padding: padding,
    backgroundColor: AppColors.white,
    borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
    border: Border.all(color: AppColors.indicatorInactive),
    elevation: AppDimensions.elevationSm,
    child: child,
  );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({super.key, required this.label, required this.onPressed, this.icon, this.assetIcon});
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? assetIcon;
  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    child: CustomDarkButton(
      width: double.infinity,
      onTap: onPressed,
      text: label,
      leading: assetIcon != null
          ? SvgAssetIcon(assetIcon!, size: AppDimensions.iconSm, color: AppColors.white)
          : icon != null ? Icon(icon, size: AppDimensions.iconSm, color: AppColors.white) : null,
    ),
  );
}

class ProfileInputStyle {
  static const double height = AppDimensions.textFieldHeight;
  static const double radius = AppDimensions.radiusSm;

  static InputDecoration decoration({
    String? hintText,
    Widget? suffixIcon,
    EdgeInsetsGeometry contentPadding = const EdgeInsets.symmetric(
      horizontal: AppDimensions.paddingSm,
      vertical: AppDimensions.spaceSm,
    ),
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(color: AppColors.indicatorInactive, width: 1),
    );
    return InputDecoration(
      hintText: hintText,
      isDense: true,
      filled: true,
      fillColor: AppColors.white,
      contentPadding: contentPadding,
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),
    );
  }
}

class ProfileDropdown extends StatelessWidget {
  const ProfileDropdown({
    super.key,
    required this.value,
    required this.options,
    required this.onChanged,
    this.fontSize = AppFontSizes.font10,
  });
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final double fontSize;

  @override
  Widget build(BuildContext context) => CustomDropDownMenu<String>(
    items: options,
    value: options.contains(value) ? value : options.first,
    itemLabel: (item) => item,
    onChanged: (next) { if (next != null) onChanged(next); },
    fontSize: fontSize,
    height: ProfileInputStyle.height,
  );
}

class ProfileField extends StatelessWidget {
  const ProfileField({super.key, required this.label, required this.value, required this.onChanged,
    this.hint, this.readOnly = false, this.maxLines = 1});
  final String label, value;
  final String? hint;
  final ValueChanged<String> onChanged;
  final bool readOnly;
  final int maxLines;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    CustomText(text: label, fontSize: AppFontSizes.font11, color: AppColors.textPrimary, fontWeight: FontWeight.w600),
    const SizedBox(height: AppDimensions.spaceSm),
    CustomTextField(
      label: label,
      initialValue: value,
      readOnly: readOnly,
      maxLines: maxLines,
      onChanged: onChanged,
      textStyle: const TextStyle(fontSize: AppFontSizes.font11, color: AppColors.textPrimary),
      inputDecoration: ProfileInputStyle.decoration(
        hintText: hint,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingSm,
          vertical: AppDimensions.spaceSm,
        ),
        suffixIcon: readOnly ? const Padding(
          padding: EdgeInsets.all(AppDimensions.spaceSm),
          child: SvgAssetIcon('key-round', size: AppDimensions.iconSm, color: AppColors.textSecondary),
        ) : null,
      ),
    ),
  ]);
}

class AvatarCircle extends StatelessWidget {
  const AvatarCircle({super.key, required this.initials, this.size = 54});
  final String initials;
  final double size;
  @override
  Widget build(BuildContext context) => CircleAvatar(
    radius: size / 2,
    backgroundColor: AppColors.primaryLight,
    child: Text(initials, style: TextStyle(
      color: AppColors.primary,
      fontWeight: FontWeight.w700,
      fontSize: size * .25,
    )),
  );
}

class MenuTile extends StatelessWidget {
  const MenuTile({
    super.key,
    this.icon,
    this.assetIcon,
    required this.title,
    required this.onTap,
    this.subtitle,
    this.iconSize = AppDimensions.iconSm,
    this.iconContainerSize = 28,
  });

  final IconData? icon;
  final String? assetIcon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final double iconSize;
  final double iconContainerSize;

  @override
  Widget build(BuildContext context) => ListTile(
    contentPadding: EdgeInsets.zero,
    dense: true,
    onTap: onTap,
    leading: Container(
      width: iconContainerSize,
      height: iconContainerSize,
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
        borderRadius: BorderRadius.circular(AppDimensions.radiusSm),
      ),
      child: assetIcon != null
          ? SvgAssetIcon(assetIcon!, size: iconSize, color: AppColors.primary)
          : Icon(
              icon ?? Icons.circle_outlined,
              size: iconSize,
              color: AppColors.primary,
            ),
    ),
    title: CustomText(
      text: title,
      color: AppColors.textPrimary,
      fontSize: AppFontSizes.font12,
      fontWeight: FontWeight.w600,
    ),
    subtitle: subtitle == null
        ? null
        : CustomText(
            text: subtitle!,
            fontSize: AppFontSizes.font10,
            color: AppColors.textSecondary,
          ),
    trailing: const SvgAssetIcon(
      'chevron-right',
      size: AppDimensions.iconSm,
      color: AppColors.textSecondary,
    ),
  );
}

class BottomLearnerNav extends StatelessWidget {
  const BottomLearnerNav({super.key, this.selected = 4});
  final int selected;
  @override
  Widget build(BuildContext context) {
    const items = ['layout-dashboard', 'book-open', 'clipboard-list', 'trophy', 'user-round'];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppDimensions.spaceSm),
      decoration: const BoxDecoration(color: AppColors.white, border: Border(top: BorderSide(color: AppColors.indicatorInactive))),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: List.generate(items.length, (i) =>
        SvgAssetIcon(items[i], size: AppDimensions.iconSm, color: i == selected ? AppColors.primary : AppColors.textSecondary))),
    );
  }
}

class SvgAssetIcon extends StatelessWidget {
  const SvgAssetIcon(this.name, {super.key, this.size = 18, this.color});
  final String name;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    AppAssets.icon('$name.svg'),
    width: size * .82,
    height: size * .82,
    colorFilter: color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn),
  );
}
