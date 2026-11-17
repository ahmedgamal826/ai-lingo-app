import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_filter_tabs.dart';
import '../widgets/quiz_list_card.dart';
import '../widgets/quizzes_header.dart';
import 'quiz_form_view.dart';
import 'quiz_overview_view.dart';

/// Quiz management tab. No Scaffold here: the app shell (with the bottom
/// navigation) will wrap it.
class QuizzesView extends StatefulWidget {
  const QuizzesView({super.key});

  @override
  State<QuizzesView> createState() => _QuizzesViewState();
}

class _QuizzesViewState extends State<QuizzesView> {
  // TODO: move to AppColors once the team agrees on a background color.
  static const Color _background = Color(0xFFF8F9FC);

  // Temporary sample data. The Cubit will provide the real values later.
  static const List<Quiz> _quizzes = [
    Quiz(
      week: 'Week 47',
      title: 'Travel with Confidence',
      status: QuizStatus.scheduled,
      schedule: 'Nov 20, 9:00 AM – Nov 22, 8:00 PM',
      summary: '20 questions · 20 min · B1',
    ),
    Quiz(
      week: 'Week 46',
      title: 'Everyday English',
      status: QuizStatus.closed,
      schedule: 'Nov 13, 9:00 AM – Nov 15, 8:00 PM',
      summary: '182 attempts · Average score 78%',
    ),
    Quiz(
      week: 'Week 45',
      title: 'The World of Work',
      status: QuizStatus.closed,
      schedule: 'Nov 6, 9:00 AM – Nov 8, 8:00 PM',
      summary: '174 attempts · Average score 81%',
    ),
    Quiz(
      week: 'Week 48',
      title: 'Connect & Converse',
      status: QuizStatus.draft,
      schedule: 'No schedule set',
      summary: '12 of 20 questions ready',
    ),
  ];

  int _tab = 0; // 0 = All, 1 = Scheduled, 2 = Completed

  List<Quiz> get _visible => switch (_tab) {
    1 => _quizzes.where((q) => q.status == QuizStatus.scheduled).toList(),
    2 => _quizzes.where((q) => q.status == QuizStatus.closed).toList(),
    _ => _quizzes,
  };

  void _open(Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: _background,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // White app bar (matches Figma), under the status bar area.
          ColoredBox(
            color: AppColors.white,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 12.h),
                child: const QuizzesHeader(),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
              children: [
                QuizActionButton.primary(
                  label: 'Create New Quiz',
                  iconName: 'plus',
                  onTap: () => _open(const QuizFormView.create()),
                ),
                SizedBox(height: 16.h),
                QuizFilterTabs(
                  labels: const ['All · 24', 'Scheduled', 'Completed'],
                  selectedIndex: _tab,
                  onChanged: (i) => setState(() => _tab = i),
                ),
                SizedBox(height: 16.h),
                for (final quiz in _visible)
                  Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: QuizListCard(
                      quiz: quiz,
                      onTap: () => _open(QuizOverviewView(quiz: quiz)),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}