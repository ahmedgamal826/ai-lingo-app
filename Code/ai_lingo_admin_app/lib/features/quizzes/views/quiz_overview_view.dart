import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/app_colors.dart';
import '../models/quiz_models.dart';
import '../viewmodels/quizzes_cubit.dart';
import '../viewmodels/quizzes_state.dart';
import '../widgets/quiz_action_button.dart';
import '../widgets/quiz_chip.dart';
import '../widgets/quiz_confirm_dialog.dart';
import '../widgets/quiz_info_box.dart';
import '../widgets/quiz_overview_details_card.dart';
import '../widgets/quiz_scaffold.dart';
import '../widgets/quiz_stats_card.dart';
import '../widgets/quiz_svg_icon.dart';
import 'quiz_form_view.dart';
import 'quiz_question_view.dart';
import 'quiz_results_view.dart';

/// Quiz overview (detail) screen.
///
/// [quiz] is only the starting value: the screen always shows the latest
/// version from the [QuizzesCubit], so edits appear right after saving.
class QuizOverviewView extends StatelessWidget {
  const QuizOverviewView({super.key, required this.quiz});

  final Quiz quiz;

  // Color of the delete icon in the app bar (same purple as the other
  // quiz icons).
  static const Color _iconColor = Color(0xFF5B6CFF);

  static const Map<String, String> _levelNames = {
    'A1': 'Beginner',
    'A2': 'Elementary',
    'B1': 'Intermediate',
    'B2': 'Upper Intermediate',
    'C1': 'Advanced',
    'C2': 'Proficiency',
  };

  static String _statusText(QuizStatus status) => switch (status) {
    QuizStatus.scheduled => 'Scheduled',
    QuizStatus.closed => 'Closed',
    QuizStatus.draft => 'Draft',
  };

  /// Opens another page and hands it the QuizzesCubit. This is needed when
  /// this screen was opened from the Dashboard (outside the Quizzes tab),
  /// because new pages can't find the Cubit on their own there.
  void _push(BuildContext context, Widget page) {
    final cubit = context.read<QuizzesCubit>();
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (_) => BlocProvider<QuizzesCubit>.value(
          value: cubit,
          child: page,
        ),
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, Quiz quiz) async {
    final cubit = context.read<QuizzesCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    final message = quiz.submissions > 0
        ? 'This quiz has ${quiz.submissions} submissions. Deleting it will permanently remove the quiz, its questions and all results. This can\'t be undone.'
        : 'This will permanently delete "${quiz.title}" and its questions. This can\'t be undone.';

    final confirmed = await showQuizConfirmDialog(
      context,
      title: 'Delete this quiz?',
      message: message,
      confirmLabel: 'Delete Quiz',
    );
    if (!confirmed) return;

    try {
      await cubit.deleteQuiz(quiz.id);
      navigator.pop();
      messenger.showSnackBar(
        SnackBar(content: Text('"${quiz.title}" was deleted')),
      );
    } catch (_) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not delete the quiz.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuizzesCubit, QuizzesState>(
      builder: (context, state) {
        final live = state.quizzes.firstWhere(
              (q) => q.id == quiz.id,
          orElse: () => quiz,
        );
        return _buildContent(context, live);
      },
    );
  }

  Widget _buildContent(BuildContext context, Quiz quiz) {
    final isClosed = quiz.status == QuizStatus.closed;

    final scheduleParts = quiz.schedule.split(' – ');
    final scheduleTitle = scheduleParts.first;
    final scheduleSubtitle = scheduleParts.length > 1
        ? '${isClosed ? 'Closed' : 'Ends'} ${scheduleParts[1]} · UTC'
        : null;

    final levelName = _levelNames[quiz.level];

    return QuizScaffold(
      title: 'Quiz overview',
      // Delete is now a trash icon in the app bar (top right).
      trailing: IconButton(
        tooltip: 'Delete quiz',
        onPressed: () => _confirmDelete(context, quiz),
        icon: QuizSvgIcon('trash-2', size: 22.w, color: _iconColor),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 24.h),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              QuizChip(quiz.week),
              Text(
                _statusText(quiz.status),
                style: TextStyle(
                  fontSize: 10.sp,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            quiz.title,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          if (quiz.description.isNotEmpty) ...[
            SizedBox(height: 6.h),
            Text(
              quiz.description,
              style: TextStyle(fontSize: 11.sp, color: AppColors.textSecondary),
            ),
          ],
          SizedBox(height: 16.h),
          QuizOverviewDetailsCard(
            rows: [
              QuizDetailRow(
                iconName: 'graduation-cap',
                title: levelName == null
                    ? quiz.level
                    : '${quiz.level} $levelName',
                subtitle:
                '${quiz.questionCount} questions · ${quiz.totalPoints} total points',
              ),
              QuizDetailRow(
                iconName: 'timer',
                title:
                '${quiz.durationMinutes} minutes · ${quiz.attempts} attempt${quiz.attempts == 1 ? '' : 's'}',
              ),
              QuizDetailRow(
                iconName: 'calendar',
                title: scheduleTitle,
                subtitle: scheduleSubtitle,
              ),
            ],
          ),
          if (isClosed) ...[
            SizedBox(height: 12.h),
            QuizStatsCard(
              headline: '${quiz.submissions} submissions',
              highlight: '${quiz.averageScore}% avg. score',
              footnote: 'Published by Jamie Morgan · Nov 10',
            ),
            SizedBox(height: 12.h),
            QuizActionButton.primary(
              label: 'View Results & Scores',
              iconName: 'chart-column',
              onTap: () => _push(
                context,
                QuizResultsView(week: quiz.week, title: quiz.title),
              ),
            ),
          ],
          SizedBox(height: 12.h),
          Row(
            children: [
              Expanded(
                child: QuizActionButton.light(
                  label: 'Edit Quiz',
                  onTap: () => _push(context, QuizFormView.edit(quiz: quiz)),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: QuizActionButton.light(
                  label: 'Edit Questions',
                  onTap: () => _push(
                    context,
                    QuizQuestionView.edit(
                      quizId: quiz.id,
                      week: quiz.week,
                      title: quiz.title,
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (isClosed) ...[
            SizedBox(height: 12.h),
            const QuizInfoBox(
              iconName: 'shield-check',
              title: 'Closed test',
              message:
              'Changes to the answer key may affect results. Review scores after editing.',
            ),
          ],
        ],
      ),
    );
  }
}
