import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_app_bar.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_button.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_card.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'reset_email_sent_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    // TODO: call send reset link, then open the next screen only on success.
    if (mounted) setState(() => _loading = false);
    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ResetEmailSentScreen(
            // email: _emailController.text.trim()
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: Column(
        children: [
          const AuthAppBar(title: 'Forgot Password'),
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
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),

                              // ---------------- Key icon ----------------
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryLight,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    'assets/icons/key-round.svg',
                                    width: 24,
                                    height: 24,
                                    colorFilter: const ColorFilter.mode(
                                      AppColors.primary,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),

                              // ---------------- Heading ----------------
                              const CustomText(
                                text: 'Let’s get you\nback to learning.',
                                fontSize: 25,
                                height: 1.3,
                                fontWeight: FontWeight.w700,
                                maxLines: 2,
                              ),
                              const SizedBox(height: 12),
                              const CustomText(
                                text:
                                    'Enter the email linked to your account. We’ll send you a secure link to reset your password.',
                                fontSize: 12,
                                height: 1.5,
                                color: AppColors.textSecondary,
                                maxLines: 3,
                              ),
                              const SizedBox(height: 24),

                              // ---------------- Email ----------------
                              CustomTextField(
                                controller: _emailController,
                                label: 'Email',
                                hint: 'alex.carter@university.edu',
                                iconAsset: 'assets/icons/mail.svg',
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.done,
                                autofillHints: const [AutofillHints.email],
                                onSubmitted: _send,
                                validator: (v) => (v == null ||
                                        !v.contains('@') ||
                                        !v.contains('.'))
                                    ? 'Enter a valid email'
                                    : null,
                              ),
                              const SizedBox(height: 16),

                              // ---------------- Button ----------------
                              CustomDarkButton(
                                text: 'Send Reset Link',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ResetEmailSentScreen(
                                          // email: _emailController.text.trim()
                                          ),
                                    ),
                                  );
                                },
                                isLoading: _loading,
                              ),
                              const SizedBox(height: 16),

                              // ---------------- Reassurance ----------------
                              SizedBox(
                                width: double.infinity,
                                child: CustomCard(
                                  backgroundColor: AppColors.primaryLight,
                                  elevation: 0,
                                  borderRadius: BorderRadius.circular(14),
                                  padding: const EdgeInsets.all(14),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset(
                                        'assets/icons/shield-check.svg',
                                        width: 16,
                                        height: 16,
                                        colorFilter: const ColorFilter.mode(
                                          AppColors.primary,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      const Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              text: 'A little reassurance',
                                              fontSize: 11,
                                              fontWeight: FontWeight.w700,
                                              maxLines: 1,
                                            ),
                                            SizedBox(height: 4),
                                            CustomText(
                                              text:
                                                  'Your progress and saved vocabulary will be right where you left them.',
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

                              const Spacer(), // Flexible space
                              // ---------------- Back to login ----------------
                              const SizedBox(height: 24),
                              Center(
                                child: GestureDetector(
                                  onTap: () => Navigator.maybePop(context),
                                  child: const CustomText(
                                    text: 'Back to Login',
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.primary,
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 24),
                            ],
                          ),
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
