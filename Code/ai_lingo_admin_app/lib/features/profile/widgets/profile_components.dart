
import 'package:ai_lingo_admin_app/features/profile/widgets/custom_app_bar.dart';
import 'package:ai_lingo_admin_app/features/profile/widgets/custom_card.dart';
import 'package:ai_lingo_admin_app/features/profile/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_dimensions.dart';

class AdminSvg extends StatelessWidget {
  const AdminSvg(this.name, {super.key, this.size = 16, this.color = AppColors.primary});
  final String name;
  final double size;
  final Color color;
  @override
  Widget build(BuildContext context) => SvgPicture.asset(
    AppAssets.icon('$name.svg'), width: size, height: size, fit: BoxFit.contain,
    colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
  );
}

class AdminPage extends StatelessWidget {
  const AdminPage({super.key, required this.title, required this.child, this.back = true});
  final String title;
  final Widget child;
  final bool back;
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.indicatorInactive ,
    appBar: CustomAppBar(
      title: title,
      centerTitle: false,
      backgroundColor: AppColors.white,
      leading: back ? IconButton(
        onPressed: () => Navigator.maybePop(context),
        icon: const Icon(Icons.arrow_back, size: 19, color: AppColors.textPrimary),
      ) : const SizedBox.shrink(),
    ),
    body: SafeArea(child: child),
  );
}

class AdminBody extends StatelessWidget {
  const AdminBody({super.key, required this.child, this.padding = const EdgeInsets.fromLTRB(20, 14, 20, 24)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => SingleChildScrollView(padding: padding, child: child);
}

class AdminCard extends StatelessWidget {
  const AdminCard({super.key, required this.child, this.padding = const EdgeInsets.all(14)});
  final Widget child;
  final EdgeInsets padding;
  @override
  Widget build(BuildContext context) => CustomCard(
    padding: padding,
    backgroundColor: AppColors.white,
    borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
    elevation: AppDimensions.elevationSm,
    child: child,
  );
}

class AdminText extends StatelessWidget {
  const AdminText(this.value, {super.key, this.size = 11, this.color = AppColors.textPrimary, this.weight = FontWeight.normal, this.align, this.maxLines});
  final String value;
  final double size;
  final Color color;
  final FontWeight weight;
  final TextAlign? align;
  final int? maxLines;
  @override
  Widget build(BuildContext context) => CustomText(
    text: value, color: color, fontSize: size, fontWeight: weight,
    textAlign: align, maxLines: maxLines,
  );
}

class AdminSectionTitle extends StatelessWidget {
  const AdminSectionTitle(this.title, {super.key});
  final String title;
  @override
  Widget build(BuildContext context) => AdminText(title, size: 12, weight: FontWeight.w700);
}

class AdminInput extends StatelessWidget {
  const AdminInput({super.key, required this.label, this.initialValue, this.onChanged, this.obscureText = false, this.suffix, this.hint});
  final String label;
  final String? initialValue, hint;
  final ValueChanged<String>? onChanged;
  final bool obscureText;
  final Widget? suffix;
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    AdminText(label, size: 10, weight: FontWeight.w600),
    const SizedBox(height: 6),
    SizedBox(height: 42, child: TextFormField(
      initialValue: initialValue, onChanged: onChanged, obscureText: obscureText,
      style: const TextStyle(fontSize: 11, color: AppColors.textPrimary),
      decoration: InputDecoration(
        hintText: hint, hintStyle: const TextStyle(fontSize: 10, color: AppColors.textSecondary),
        filled: true, fillColor: AppColors.white, isDense: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 11, vertical: 12),
        suffixIcon: suffix, suffixIconConstraints: const BoxConstraints(minWidth: 36, minHeight: 36),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.indicatorInactive)),
        enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.indicatorInactive)),
        focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: const BorderSide(color: AppColors.primary)),
      ),
    )),
  ]);
}

class AdminPrimaryButton extends StatelessWidget {
  const AdminPrimaryButton({super.key, required this.label, required this.onPressed, this.pink = false});
  final String label;
  final VoidCallback onPressed;
  final bool pink;
  @override
  Widget build(BuildContext context) => SizedBox(width: double.infinity, height: 42, child: ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      elevation: 0, backgroundColor: pink ? AppColors.errorLight : AppColors.primary,
      foregroundColor: pink ? AppColors.danger : AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
    ),
    child: AdminText(label, size: 11, color: pink ? AppColors.danger : AppColors.white, weight: FontWeight.w700),
  ));
}

class AdminToggleRow extends StatelessWidget {
  const AdminToggleRow({super.key, required this.title, required this.subtitle, required this.value, required this.onChanged});
  final String title, subtitle;
  final bool value;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) => Row(children: [
    Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      AdminText(title, size: 10, weight: FontWeight.w600),
      const SizedBox(height: 3), AdminText(subtitle, size: 8, color: AppColors.textSecondary),
    ])),
    Transform.scale(scale: .78, child: Switch.adaptive(
      value: value, onChanged: onChanged, activeColor: AppColors.white,
      activeTrackColor: AppColors.primary, inactiveThumbColor: AppColors.white,
      inactiveTrackColor: AppColors.indicatorInactive,
      trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
    )),
  ]);
}
