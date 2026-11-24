import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../viewmodels/quizzes_cubit.dart';
import '../viewmodels/quizzes_state.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_filter_tabs.dart';
import '../widgets/quiz_list_card.dart';
import '../widgets/quizzes_header.dart';
import 'quiz_form_view.dart';
import 'quiz_overview_view.dart';

/// Quiz management tab. No Scaffold here: the app shell (with the bottom
/// navigation) wraps it.
class QuizzesView extends StatefulWidget {
  const QuizzesView({super.key});

  @override
  State<QuizzesView> createState() => _QuizzesViewState();
}

class _QuizzesViewState extends State<QuizzesView> {
  // TODO: move to AppColors once the team agrees on a background color.
  static const Color _background = Color(0xFFF8F9FC);

  int _tab = 0; // 0 = All, 1 = Scheduled, 2 = Completed

  List<Quiz> _visible(List<Quiz> quizzes) => switch (_tab) {
    1 => quizzes.where((q) => q.status == QuizStatus.scheduled).toList(),
    2 => quizzes.where((q) => q.status == QuizStatus.closed).toList(),
    _ => quizzes,
  };

  void _open(Widget page) {
    Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => page));
  }

  Widget _buildBody(QuizzesState state) {
    if (state.status == QuizzesStatus.initial ||
        state.status == QuizzesStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.status == QuizzesStatus.failure) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              state.errorMessage ?? 'Something went wrong.',
              style: TextStyle(fontSize: 12.sp, color: AppColors.textSecondary),
            ),
            TextButton(
              onPressed: () => context.read<QuizzesCubit>().load(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    final visible = _visible(state.quizzes);

    return ListView(
      padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
      children: [
        QuizActionButton.primary(
          label: 'Create New Quiz',
          iconName: 'plus',
          onTap: () => _open(const QuizFormView.create()),
        ),
        SizedBox(height: 16.h),
        QuizFilterTabs(
          labels: ['All · ${state.quizzes.length}', 'Scheduled', 'Completed'],
          selectedIndex: _tab,
          onChanged: (i) => setState(() => _tab = i),
        ),
        SizedBox(height: 16.h),
        if (visible.isEmpty)
          Padding(
            padding: EdgeInsets.symmetric(vertical: 32.h),
            child: Center(
              child: Text(
                'No quizzes here yet.',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
          ),
        for (final quiz in visible)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: QuizListCard(
              quiz: quiz,
              onTap: () => _open(QuizOverviewView(quiz: quiz)),
            ),
          ),
      ],
    );
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
            child: BlocBuilder<QuizzesCubit, QuizzesState>(
              builder: (context, state) => _buildBody(state),
            ),
          ),
        ],
      ),
    );
  }
}