import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_button.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_card.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text.dart';
import 'package:ai_lingo_user_app/features/auth/views/login_view.dart';
import 'package:ai_lingo_user_app/features/auth/views/onboarding/page1.dart';
import 'package:ai_lingo_user_app/features/auth/views/onboarding/page2.dart';
import 'package:ai_lingo_user_app/features/auth/views/onboarding/page3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnboardingData {
  final Widget Function() preview;
  final String iconAsset;
  final String eyebrow;
  final String title;
  final String description;
  final String button;
  const OnboardingData({
    required this.preview,
    required this.iconAsset,
    required this.eyebrow,
    required this.title,
    required this.description,
    required this.button,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _index = 0;

  late final List<OnboardingData> _pages = [
    OnboardingData(
      preview: Page1.new,
      iconAsset: 'assets/icons/sparkles.svg',
      eyebrow: 'MADE FOR YOU',
      title: 'Your English.\nYour own pace.',
      description:
          'An AI learning partner that adapts to your level, your goals, and the way you learn.',
      button: 'Next',
    ),
    OnboardingData(
      preview: Page2.new,
      iconAsset: 'assets/icons/chat_bubbles.svg',
      eyebrow: 'SPEAK WITH CONFIDENCE',
      title: 'Real conversations.\nReal confidence.',
      description:
          'From ordering coffee to your next interview, practice everyday English without the pressure.',
      button: 'Next',
    ),
    OnboardingData(
      preview: Page3.new,
      iconAsset: 'assets/icons/book-open.svg',
      eyebrow: 'MAKE EVERY WORD COUNT',
      title: 'New words.\nBigger possibilities.',
      description:
          'Save useful words, hear their pronunciation, and turn new vocabulary into everyday language.',
      button: 'Get Started',
    ),
  ];

  void _next() {
    if (_index < _pages.length - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOut,
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(height: 14),
              // ---------- Header ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CustomText(
                    text: 'AI-Lingo.',
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                    maxLines: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const CustomText(
                      text: 'Skip',
                      fontSize: 12,
                      color: AppColors.textSecondary,
                      maxLines: 1,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),

              // ---------- Pages ----------
              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _pages.length,
                  onPageChanged: (i) => setState(() => _index = i),
                  itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
                ),
              ),

              // ---------- Dots ----------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(_pages.length, (i) {
                  final active = i == _index;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: active ? 16 : 5,
                    height: 5,
                    decoration: BoxDecoration(
                      color: active
                          ? AppColors.primary
                          : AppColors.indicatorInactive,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  );
                }),
              ),
              const SizedBox(height: 16),

              // ---------- Button ----------
              CustomDarkButton(
                text: _pages[_index].button,
                onTap: _next,
                icon: Icons.arrow_forward_rounded,
              ),
              const SizedBox(height: 20),

              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
    );
  }
}

// =====================================================================
// One page
// =====================================================================
class _OnboardingPage extends StatelessWidget {
  final OnboardingData data;
  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Preview card 350 x 282  (CustomCard.hero = tinted big card)
        SizedBox(
          width: double.infinity,
          height: 282,
          child: CustomCard.hero(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.12),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      data.iconAsset,
                      width: 22,
                      height: 22,
                      colorFilter: const ColorFilter.mode(
                        AppColors.primary,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18), // gap 18
                data.preview(),
              ],
            ),
          ),
        ),
        const SizedBox(height: 14),

        // Eyebrow
        CustomText(
          text: data.eyebrow,
          fontSize: 7,
          letterSpacing: 0.5,
          fontWeight: FontWeight.w700,
          color: AppColors.primary,
          maxLines: 1,
        ),
        const SizedBox(height: 8),

        // Headline
        CustomText(
          text: data.title,
          fontSize: 26,
          height: 30 / 26,
          fontWeight: FontWeight.w800,
          letterSpacing: -0.5,
          maxLines: 2,
        ),
        const SizedBox(height: 12),

        // Description
        CustomText(
          text: data.description,
          fontSize: 11,
          height: 1.5,
          color: AppColors.textSecondary,
          maxLines: 3,
        ),
      ],
    );
  }
}
