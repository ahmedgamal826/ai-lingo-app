import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileColors {
  static const primary = Color(0xFF5B6CFF);
  static const primaryLight = Color(0xFFEEF0FF);
  static const ink = Color(0xFF252943);
  static const muted = Color(0xFF9299B1);
  static const line = Color(0xFFE9EBF4);
  static const background = Color(0xFFF7F8FC);
  static const pink = Color(0xFFFFF0F3);
  static const green = Color(0xFFEAF8F3);
  static const success = Color(0xFF229C78);
  static const violet = Color(0xFF8B5CF6);
  static const danger = Color(0xFFD45B70);
}

class ProfilePage extends StatelessWidget {
  const ProfilePage(
      {super.key, required this.title, required this.child, this.back = true});
  final String title;
  final Widget child;
  final bool back;
  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: ProfileColors.background,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          automaticallyImplyLeading: back,
          leading: back
              ? IconButton(
                  icon: Transform.rotate(
                      angle: 3.14159,
                      child: SvgAssetIcon('chevron-right',
                          size: 16, color: ProfileColors.ink)),
                  onPressed: () => Navigator.maybePop(context),
                )
              : null,
          title: Text(title,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  color: ProfileColors.ink)),
        ),
        body: SafeArea(child: child),
      );
}

class ProfileBody extends StatelessWidget {
  const ProfileBody(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.fromLTRB(20, 12, 20, 24)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        padding: padding,
        child: child,
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});
  final String text;
  final Widget? trailing;
  @override
  Widget build(BuildContext context) => Row(children: [
        Expanded(
            child: Text(text,
                style: const TextStyle(
                    color: ProfileColors.ink,
                    fontSize: 12,
                    fontWeight: FontWeight.w700))),
        if (trailing != null) trailing!,
      ]);
}

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {super.key,
      required this.child,
      this.padding = const EdgeInsets.all(14)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => Container(
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(11),
            border: Border.all(color: ProfileColors.line.withOpacity(.8)),
            boxShadow: const [
              BoxShadow(
                  color: Color(0x08000000), blurRadius: 8, offset: Offset(0, 2))
            ]),
        child: Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(11),
          clipBehavior: Clip.antiAlias,
          child: Padding(padding: padding, child: child),
        ),
      );
}

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.label,
      required this.onPressed,
      this.icon,
      this.assetIcon});
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;
  final String? assetIcon;
  @override
  Widget build(BuildContext context) => SizedBox(
      width: double.infinity,
      height: 42,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Row(mainAxisSize: MainAxisSize.min, children: [
          if (assetIcon != null)
            SvgAssetIcon(assetIcon!, size: 14, color: Colors.white)
          else if (icon != null)
            Icon(icon, size: 16),
          if (assetIcon != null || icon != null) const SizedBox(width: 8),
          Text(label,
              style:
                  const TextStyle(fontWeight: FontWeight.w600, fontSize: 11)),
        ]),
        style: ElevatedButton.styleFrom(
            backgroundColor: ProfileColors.primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      ));
}

/// Shared decoration used by text fields and dropdowns to keep both controls
/// visually identical to the supplied mobile UI reference.
class ProfileInputStyle {
  static const double height = 42;
  static const double radius = 8;

  static InputDecoration decoration({
    String? hintText,
    Widget? suffixIcon,
    EdgeInsetsGeometry contentPadding =
        const EdgeInsets.symmetric(horizontal: 11, vertical: 8),
  }) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(radius),
      borderSide: const BorderSide(color: ProfileColors.line, width: 1),
    );
    return InputDecoration(
      hintText: hintText,
      isDense: true,
      filled: true,
      fillColor: Colors.white,
      contentPadding: contentPadding,
      suffixIcon: suffixIcon,
      suffixIconConstraints: const BoxConstraints(minWidth: 34, minHeight: 34),
      border: border,
      enabledBorder: border,
      disabledBorder: border,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(radius),
        borderSide: const BorderSide(color: ProfileColors.primary, width: 1),
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
    this.fontSize = 10,
  });

  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;
  final double fontSize;

  @override
  Widget build(BuildContext context) => SizedBox(
        height: ProfileInputStyle.height,
        child: DropdownButtonFormField<String>(
          value: options.contains(value) ? value : options.first,
          isExpanded: true,
          icon: const SvgAssetIcon('chevron-right',
              size: 12, color: ProfileColors.muted),
          items: options
              .map((item) => DropdownMenuItem<String>(
                    value: item,
                    child: Text(item,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: fontSize, color: ProfileColors.ink)),
                  ))
              .toList(),
          onChanged: (next) {
            if (next != null) onChanged(next);
          },
          decoration: ProfileInputStyle.decoration(),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
      );
}

class ProfileField extends StatelessWidget {
  const ProfileField(
      {super.key,
      required this.label,
      required this.value,
      required this.onChanged,
      this.hint,
      this.readOnly = false,
      this.maxLines = 1});
  final String label, value;
  final String? hint;
  final ValueChanged<String> onChanged;
  final bool readOnly;
  final int maxLines;
  @override
  Widget build(BuildContext context) =>
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label,
            style: const TextStyle(
                fontSize: 11,
                color: ProfileColors.ink,
                fontWeight: FontWeight.w600)),
        const SizedBox(height: 7),
        TextFormField(
          initialValue: value,
          readOnly: readOnly,
          maxLines: maxLines,
          onChanged: onChanged,
          style: const TextStyle(fontSize: 11, color: ProfileColors.ink),
          decoration: ProfileInputStyle.decoration(
            hintText: hint,
            contentPadding: EdgeInsets.symmetric(
                horizontal: 11, vertical: maxLines > 1 ? 10 : 8),
            suffixIcon: readOnly
                ? const Padding(
                    padding: EdgeInsets.all(9),
                    child: SvgAssetIcon('key-round',
                        size: 14, color: ProfileColors.muted))
                : null,
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
      backgroundColor: ProfileColors.primaryLight,
      child: Text(initials,
          style: TextStyle(
              color: ProfileColors.primary,
              fontWeight: FontWeight.w700,
              fontSize: size * .25)));
}

class MenuTile extends StatelessWidget {
  const MenuTile(
      {super.key,
      this.icon,
      this.assetIcon,
      required this.title,
      required this.onTap,
      this.subtitle});
  final IconData? icon;
  final String? assetIcon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => ListTile(
        contentPadding: EdgeInsets.zero,
        dense: true,
        onTap: onTap,
        leading: Container(
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: ProfileColors.primaryLight,
                borderRadius: BorderRadius.circular(9)),
            child: assetIcon != null
                ? SizedBox(
                    width: 28,
                    height: 28,
                    child: Center(
                      child: SvgPicture.asset(
                        'assets/icons/$assetIcon.svg',
                        width: 16,
                        height: 16,
                        fit: BoxFit.contain,
                        colorFilter: const ColorFilter.mode(
                          ProfileColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  )
                // ? SvgAssetIcon(assetIcon!, size: 14, color: ProfileColors.primary)
                : Icon(icon ?? Icons.circle_outlined,
                    size: 14, color: ProfileColors.primary)),
        title: Text(title,
            style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: ProfileColors.ink)),
        subtitle: subtitle == null
            ? null
            : Text(subtitle!,
                style:
                    const TextStyle(fontSize: 10, color: ProfileColors.muted)),
        trailing: const SvgAssetIcon('chevron-right',
            size: 14, color: ProfileColors.muted),
      );
}

class BottomLearnerNav extends StatelessWidget {
  const BottomLearnerNav({super.key, this.selected = 4});
  final int selected;
  @override
  Widget build(BuildContext context) {
    const items = [
      'layout-dashboard',
      'book-open',
      'clipboard-list',
      'trophy',
      'user-round'
    ];
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: ProfileColors.line))),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(
              items.length,
              (i) => SvgAssetIcon(items[i],
                  size: 15,
                  color: i == selected
                      ? ProfileColors.primary
                      : ProfileColors.muted))),
    );
  }
}

class SvgAssetIcon extends StatelessWidget {
  const SvgAssetIcon(this.name, {super.key, this.size = 18, this.color});
  final String name;
  final double size;
  final Color? color;
  @override
  Widget build(BuildContext context) =>
      SvgPicture.asset('assets/icons/$name.svg',
          width: size * .82,
          height: size * .82,
          colorFilter:
              color == null ? null : ColorFilter.mode(color!, BlendMode.srcIn));
}
