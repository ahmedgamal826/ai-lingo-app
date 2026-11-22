import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_button.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text_field.dart';
import 'package:ai_lingo_user_app/features/auth/views/en_level_selection.dart';
import 'package:ai_lingo_user_app/features/auth/views/forget_password_view.dart';
import 'package:ai_lingo_user_app/features/auth/views/sign_up_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);
    // TODO: call login
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 14),

                        // ---------------- Brand ----------------
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/language.svg',
                              width: 24,
                              height: 24,
                              colorFilter: const ColorFilter.mode(
                                AppColors.primary,
                                BlendMode.srcIn,
                              ),
                            ),
                            const SizedBox(width: 8),
                            const CustomText(
                              text: 'AI-Lingo.',
                              fontSize: 20,
                              fontWeight: FontWeight.w800,
                              maxLines: 1,
                            ),
                          ],
                        ),

                        // ---------------- Welcome ----------------
                        const Padding(
                          padding: EdgeInsets.only(top: 37, bottom: 18),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                text: 'Welcome back 👋',
                                fontSize: 32,
                                height: 1.2,
                                fontWeight: FontWeight.w800,
                                letterSpacing: -0.5,
                                maxLines: 1,
                              ),
                              SizedBox(height: 10), // gap 10
                              CustomText(
                                text:
                                    'Your next conversation is a step forward.\nLet’s keep learning.',
                                fontSize: 13,
                                height: 1.5,
                                color: AppColors.textSecondary,
                                maxLines: 2,
                              ),
                            ],
                          ),
                        ),

                        // ---------------- Email ----------------
                        CustomTextField(
                          controller: _emailController,
                          label: 'Email',
                          hint: 'alex.carter@university.edu',
                          iconAsset: 'assets/icons/mail.svg',
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          autofillHints: const [AutofillHints.email],
                          validator: (v) =>
                              (v == null ||
                                  !v.contains('@') ||
                                  !v.contains('.'))
                              ? 'Enter a valid email'
                              : null,
                        ),
                        const SizedBox(height: 16),

                        // ---------------- Password ----------------
                        CustomTextField(
                          controller: _passwordController,
                          label: 'Password',
                          hint: 'Enter your password',
                          obscureText: true,
                          textInputAction: TextInputAction.done,
                          onSubmitted: _login,
                          validator: (v) => (v == null || v.isEmpty)
                              ? 'Enter your password'
                              : null,
                        ),
                        const SizedBox(height: 14),

                        // ---------------- Forgot password ----------------
                        Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const ForgotPasswordScreen(),
                                ),
                              );
                            },
                            child: const CustomText(
                              text: 'Forgot Password?',
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primary,
                              maxLines: 1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 18),

                        // ---------------- Login button ----------------
                        CustomDarkButton(
                          text: 'Login',
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LevelSelectionScreen(),
                              ),
                            );
                          },
                          isLoading: _loading,
                        ),
                        const SizedBox(height: 18),

                        // ---------------- Registration link ----------------
                        Center(
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const SignUpScreen(),
                                ),
                              );
                            },
                            child: RichText(
                              text: const TextSpan(
                                style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                                children: [
                                  TextSpan(text: 'Don’t have an account?  '),
                                  TextSpan(
                                    text: 'Sign Up',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      color: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        const Spacer(), // Flexible space
                        // ---------------- Footer ----------------
                        const SizedBox(height: 24),
                        const Divider(
                          height: 1,
                          thickness: 1,
                          color: AppColors.indicatorInactive,
                        ),
                        const SizedBox(height: 12),
                        const Center(
                          child: CustomText(
                            text:
                                'By continuing, you agree to our Terms of Service\nand Privacy Policy.',
                            fontSize: 10,
                            height: 1.5,
                            color: AppColors.textSecondary,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
