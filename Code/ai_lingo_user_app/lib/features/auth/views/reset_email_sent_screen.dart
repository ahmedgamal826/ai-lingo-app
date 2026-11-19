import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/core/widgets/custom_app_bar.dart';
import 'package:ai_lingo_user_app/core/widgets/custom_button.dart';
import 'package:ai_lingo_user_app/core/widgets/custom_card.dart';
import 'package:ai_lingo_user_app/core/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetEmailSentScreen extends StatelessWidget {
  const ResetEmailSentScreen({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: Column(
        children: [
          const AuthAppBar(title: 'Check your inbox'),
          Expanded(
            child: SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          children: [
                            const Spacer(), // Flexible space (top)
                            // ---------------- Confirmation symbol ----------------
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                color: AppColors.successLight,
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/mail-check.svg',
                                  width: 36,
                                  height: 36,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.success,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // ---------------- Title + subtitle ----------------
                            const CustomText(
                              text: 'You’ve got mail.',
                              fontSize: 26,
                              height: 1.2,
                              fontWeight: FontWeight.w700,
                              textAlign: TextAlign.center,
                              maxLines: 1,
                            ),
                            const SizedBox(height: 12),
                            CustomText(
                              text: 'We sent a password reset link to\n$email.',
                              fontSize: 13,
                              height: 1.5,
                              color: AppColors.textSecondary,
                              textAlign: TextAlign.center,
                              maxLines: 3,
                            ),
                            const SizedBox(height: 20),

                            // ---------------- Information banner ----------------
                            SizedBox(
                              width: double.infinity,
                              child: CustomCard(
                                backgroundColor: AppColors.successLight,
                                elevation: 0,
                                borderRadius: BorderRadius.circular(14),
                                padding: const EdgeInsets.all(14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SvgPicture.asset(
                                      'assets/icons/circle-check.svg',
                                      width: 16,
                                      height: 16,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.success,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const SizedBox(width: 12), // gap 12
                                    const Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: 'All set',
                                            fontSize: 11,
                                            fontWeight: FontWeight.w700,
                                            maxLines: 1,
                                          ),
                                          SizedBox(height: 4),
                                          CustomText(
                                            text:
                                                'The link is valid for 30 minutes. Check your spam folder if you can’t find it.',
                                            fontSize: 10,
                                            height: 1.5,
                                            color: AppColors.textSecondary,
                                            maxLines: 3,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            const Spacer(), // Flexible space (bottom)
                            // ---------------- Button ----------------
                            const SizedBox(height: 24),
                            CustomDarkButton(
                              text: 'Back to Login',
                              onTap: () => Navigator.popUntil(
                                context,
                                (route) => route.isFirst,
                              ),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
