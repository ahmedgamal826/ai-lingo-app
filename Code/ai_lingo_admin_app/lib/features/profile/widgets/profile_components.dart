import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdminColors {
  static const primary = Color(0xFF5B6CFF);
  static const primaryLight = Color(0xFFEEF0FF);
  static const ink = Color(0xFF252943);
  static const muted = Color(0xFF9299B1);
  static const line = Color(0xFFE9EBF4);
  static const background = Color(0xFFF7F8FC);
  static const pink = Color(0xFFFFF0F3);
  static const danger = Color(0xFFE96B83);
  static const green = Color(0xFFE8F7F1);
  static const success = Color(0xFF229C78);
}

class AdminSvg extends StatelessWidget {
  const AdminSvg(this.name, {super.key, this.size = 16, this.color = AdminColors.primary});
  final String name; final double size; final Color color;
  @override Widget build(BuildContext context) => SvgPicture.asset('assets/icons/$name.svg',
    width: size, height: size, fit: BoxFit.contain,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn));
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key, required this.title, required this.child, this.back = true});
  final String title; final Widget child; final bool back;
  @override Widget build(BuildContext context) => Scaffold(
    backgroundColor: AdminColors.background,
    appBar: AppBar(backgroundColor: Colors.white, elevation: 0, scrolledUnderElevation: 0,
      toolbarHeight: 56, automaticallyImplyLeading: false,
      leading: back ? IconButton(onPressed: () => Navigator.maybePop(context),
        icon: const Icon(Icons.arrow_back, size: 19, color: AdminColors.ink)) : null,
      title: Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AdminColors.ink))),
    body: SafeArea(child: child));
}

class AdminBody extends StatelessWidget {
  const AdminBody({super.key, required this.child, this.padding = const EdgeInsets.fromLTRB(20, 14, 20, 24)});
  final Widget child; final EdgeInsets padding;
  @override Widget build(BuildContext context) => SingleChildScrollView(padding: padding, child: child);
}

class AdminCard extends StatelessWidget {
  const AdminCard({super.key, required this.child, this.padding = const EdgeInsets.all(14)});
  final Widget child; final EdgeInsets padding;
  @override Widget build(BuildContext context) => Container(width: double.infinity, padding: padding,
    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13),
      boxShadow: const [BoxShadow(color: Color(0x08000000), blurRadius: 10, offset: Offset(0, 3))]), child: child);
}

class AdminSectionTitle extends StatelessWidget {
  const AdminSectionTitle(this.title, {super.key}); final String title;
  @override Widget build(BuildContext context) => Text(title, style: const TextStyle(fontSize: 12,
    fontWeight: FontWeight.w700, color: AdminColors.ink));
}

class AdminInput extends StatelessWidget {
  const AdminInput({super.key, required this.label, this.initialValue, this.onChanged, this.obscureText = false,
    this.suffix, this.hint});
  final String label; final String? initialValue, hint; final ValueChanged<String>? onChanged;
  final bool obscureText; final Widget? suffix;
  @override Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(fontSize: 10, color: AdminColors.ink, fontWeight: FontWeight.w600)),
    const SizedBox(height: 6),
    SizedBox(height: 42, child: TextFormField(initialValue: initialValue, onChanged: onChanged, obscureText: obscureText,
      style: const TextStyle(fontSize: 11, color: AdminColors.ink),
      decoration: InputDecoration(hintText: hint, hintStyle: const TextStyle(fontSize: 10, color: AdminColors.muted),
        filled: true, fillColor: Colors.white, isDense: true, contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
        suffixIcon: suffix, suffixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AdminColors.line)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AdminColors.line)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AdminColors.primary))))),
  ]);
}

class AdminPrimaryButton extends StatelessWidget {
  const AdminPrimaryButton({super.key, required this.label, required this.onPressed, this.pink = false});
  final String label; final VoidCallback onPressed; final bool pink;
  @override Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 42,
    child: ElevatedButton(onPressed: onPressed, style: ElevatedButton.styleFrom(elevation: 0,
      backgroundColor: pink ? AdminColors.pink : AdminColors.primary,
      foregroundColor: pink ? AdminColors.danger : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9))),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700))));
}

class AdminToggleRow extends StatelessWidget {
  const AdminToggleRow({super.key, required this.title, required this.subtitle, required this.value, required this.onChanged});
  final String title, subtitle; final bool value; final ValueChanged<bool> onChanged;
  @override Widget build(BuildContext context) => Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: AdminColors.ink)),
      const SizedBox(height: 3), Text(subtitle, style: const TextStyle(fontSize: 8, color: AdminColors.muted)),
    ])),
    Transform.scale(scale: .78, child: Switch.adaptive(value: value, onChanged: onChanged,
      activeColor: Colors.white, activeTrackColor: AdminColors.primary,
      inactiveThumbColor: Colors.white, inactiveTrackColor: const Color(0xFFE7EAF2),
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent))),
  ]);
}
