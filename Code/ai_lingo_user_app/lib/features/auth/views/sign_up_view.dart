import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_app_bar.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_button.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_dialog.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text_field.dart';
import 'package:ai_lingo_user_app/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _agree = false;
  bool _loading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    super.dispose();
  }

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agree) {
      await CustomDialog.showInfo(
        context,
        title: 'Terms of Service',
        message:
            'Please agree to our Terms of Service and Privacy Policy to continue.',
      );
      return;
    }
    setState(() => _loading = true);
    // TODO: call sign up
    if (mounted) setState(() => _loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          const AuthAppBar(title: 'Create your account'),
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ---------------- Heading ----------------
                      const CustomText(
                        text: 'A new chapter starts here.',
                        fontSize: 25,
                        height: 1.4,
                        fontWeight: FontWeight.w700,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 12),
                      const CustomText(
                        text:
                            'Build your confidence, one conversation at a time.',
                        fontSize: 13,
                        height: 1.4,
                        color: AppColors.textSecondary,
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),

                      // ---------------- Fields ----------------
                      CustomTextField(
                        controller: _nameController,
                        label: 'Full Name',
                        hint: 'Alex Carter',
                        iconAsset: 'assets/icons/user-round.svg',
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        validator: (v) => (v == null || v.trim().isEmpty)
                            ? 'Please enter your name'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _emailController,
                        label: 'Email',
                        hint: 'alex.carter@university.edu',
                        iconAsset: 'assets/icons/mail.svg',
                        keyboardType: TextInputType.emailAddress,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.email],
                        validator: (v) =>
                            (v == null || !v.contains('@') || !v.contains('.'))
                            ? 'Enter a valid email'
                            : null,
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hint: 'Create a password',
                        obscureText: true,
                        helperText:
                            'At least 8 characters, including a number.',
                        textInputAction: TextInputAction.next,
                        validator: (v) {
                          if (v == null || v.length < 8) {
                            return 'At least 8 characters';
                          }
                          if (!RegExp(r'\d').hasMatch(v)) {
                            return 'Include at least one number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      CustomTextField(
                        controller: _confirmController,
                        label: 'Confirm Password',
                        hint: 'Repeat your password',
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        onSubmitted: _signUp,
                        validator: (v) => v != _passwordController.text
                            ? 'Passwords do not match'
                            : null,
                      ),
                      const SizedBox(height: 14),

                      // ---------------- Terms ----------------
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () => setState(() => _agree = !_agree),
                        child: Row(
                          children: [
                            AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _agree
                                    ? AppColors.primary
                                    : AppColors.white,
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: _agree
                                      ? AppColors.primary
                                      : AppColors.indicatorInactive,
                                  width: 1.5,
                                ),
                              ),
                              child: _agree
                                  ? const Icon(
                                      Icons.check,
                                      size: 12,
                                      color: AppColors.white,
                                    )
                                  : null,
                            ),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: CustomText(
                                text:
                                    'Agree to our Terms of Service and Privacy Policy.',
                                fontSize: 11,
                                color: AppColors.textSecondary,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // ---------------- Button ----------------
                      CustomDarkButton(
                        text: 'Sign Up',
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        isLoading: _loading,
                      ),
                      const SizedBox(height: 12),

                      // ---------------- Login link ----------------
                      Center(
                        child: GestureDetector(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          ),
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontSize: 12,
                                color: AppColors.textSecondary,
                              ),
                              children: [
                                TextSpan(text: 'Already have an account?  '),
                                TextSpan(
                                  text: 'Login',
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
