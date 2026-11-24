import 'package:ai_lingo_user_app/core/theme/app_colors.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_app_bar.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_button.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_card.dart';
import 'package:ai_lingo_user_app/features/auth/widgets/custom_text.dart';
import 'package:ai_lingo_user_app/features/home/views/home_view.dart';
import 'package:flutter/material.dart';

class _Level {
  const _Level(this.badge, this.title, this.subtitle);
  final String badge;
  final String title;
  final String subtitle;
}

const _levels = [
  _Level('A1–A2', 'Beginner', 'I know a few words and simple phrases.'),
  _Level('B1', 'Intermediate', 'I can talk about familiar topics.'),
  _Level('B2', 'Upper intermediate', 'I can express ideas and opinions.'),
  _Level('C1–C2', 'Advanced', 'I want to refine my fluency.'),
];

class LevelSelectionScreen extends StatefulWidget {
  const LevelSelectionScreen({super.key});

  @override
  State<LevelSelectionScreen> createState() => _LevelSelectionScreenState();
}

class _LevelSelectionScreenState extends State<LevelSelectionScreen> {
  int _selected = 1; // Intermediate (as in the design)

  void _start() async {
    final selectedLevel = _levels[_selected];

    // final prefs = await SharedPreferences.getInstance();
    // await prefs.setString('selectedLevel', selectedLevel);

    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HomeView()),
    );
  }

  Widget _badge(String text, bool selected) {
    return Container(
      width: 36,
      height: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: selected ? AppColors.primary : AppColors.indicatorInactive,
        borderRadius: BorderRadius.circular(10),
      ),
      child: CustomText(
        text: text,
        fontSize: 9,
        fontWeight: FontWeight.w700,
        color: selected ? AppColors.white : AppColors.textSecondary,
        maxLines: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FC),
      body: Column(
        children: [
          const AuthAppBar(
            child: SizedBox(),
            title: 'Make it yours',
            subtitle: 'ACCOUNT CREATED · LAST STEP',
          ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 20),

                            // ---------------- Heading ----------------
                            const CustomText(
                              text: 'Where are you on\nyour English journey?',
                              fontSize: 26,
                              height: 1.4,
                              fontWeight: FontWeight.w700,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 12),
                            const CustomText(
                              text:
                                  'Choose your current level. You can change this anytime in your learning preferences.',
                              fontSize: 13,
                              height: 1.4,
                              color: AppColors.textSecondary,
                              maxLines: 2,
                            ),
                            const SizedBox(height: 16),

                            // ---------------- Level options ----------------
                            for (var i = 0; i < _levels.length; i++) ...[
                              if (i != 0) const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: CustomCard.selectable(
                                  title: _levels[i].title,
                                  subtitle: _levels[i].subtitle,
                                  selected: i == _selected,
                                  leading: _badge(
                                    _levels[i].badge,
                                    i == _selected,
                                  ),
                                  onTap: () => setState(() => _selected = i),
                                ),
                              ),
                            ],

                            const Spacer(), // Flexible space
                            // ---------------- Button ----------------
                            const SizedBox(height: 24),
                            CustomDarkButton(
                              text: 'Start My Journey',
                              icon: Icons.arrow_forward_rounded,
                              onTap: _start,
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
