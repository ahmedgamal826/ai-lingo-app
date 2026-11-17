import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';

/// Page frame shared by every full-screen quiz page: white app bar
/// (back arrow + title + optional subtitle/trailing) over the grey body.
class QuizScaffold extends StatelessWidget {
  const QuizScaffold({
    super.key,
    required this.title,
    required this.body,
    this.subtitle,
    this.trailing,
    this.onBack,
  });

  final String title;

  /// Small caps line under the title, e.g. "WEEK 46 · EVERYDAY ENGLISH".
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onBack;
  final Widget body;

  // TODO: move to AppColors once the team agrees on a background color.
  static const Color background = Color(0xFFF8F9FC);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: AppColors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(8.w, 8.h, 12.w, 12.h),
                child: Row(
                  children: [
                    IconButton(
                      onPressed:
                      onBack ?? () => Navigator.of(context).maybePop(),
                      icon: const Icon(
                        Icons.arrow_back,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          if (subtitle != null) ...[
                            SizedBox(height: 2.h),
                            Text(
                              subtitle!,
                              style: TextStyle(
                                fontSize: 9.sp,
                                letterSpacing: 0.6,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    ?trailing,
                  ],
                ),
              ),
            ),
          ),
          Expanded(child: body),
        ],
      ),
    );
  }
}